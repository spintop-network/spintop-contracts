// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/utils/ReentrancyGuardUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/ContextUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/PausableUpgradeable.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "../Interfaces/IIGO.sol";

/// @title Spinstarter IGO Claim
/// @author Spintop.Network
/// @notice Pay for and claim earned tokens.
/// @dev 'Dollars' symbolize underlying payment tokens. Assumed 18 decimal.
contract IGOClaim is Initializable, ContextUpgradeable, PausableUpgradeable, OwnableUpgradeable, ReentrancyGuardUpgradeable {
    using SafeERC20 for IERC20;

    address public paymentToken;
    address public token;
    uint256 public totalDollars;
    uint256 public totalClaimed;
    uint32 public _startDate;
    uint32 public _duration;
    uint32 public _refundPeriodStart;
    uint32 public _refundPeriodEnd;
    uint32 public price;
    uint8 public decimal;
    uint8 public priceDecimal;
    uint8 public claimPercentage;
    bool public isLinear;
    mapping(address => bool) public refunded;
    mapping(address => uint256) public paidAmounts;
    mapping(address => uint256) public claimedAmounts;
    mapping(address => uint256) public claimedTokens;

    error LinearVestingDisabled();
    error AmountIsZero();
    error AlreadyClaimed();
    error AlreadyRefunded();
    error RefundPeriodNotStarted();
    error RefundPeriodEnded();
    error AllTokensClaimed();
    error NotEnoughTokens();
    error TransferFailed();

    function initialize(
        uint256 _totalDollars,
        uint32 _price,
        address _paymentToken,
        address initialOwner,
        uint8 _priceDecimal,
        bool _isLinear
    ) initializer public {
        __Ownable_init(initialOwner);
        totalDollars = _totalDollars;
        paymentToken = _paymentToken;
        price = _price;
        priceDecimal = _priceDecimal;
        isLinear = _isLinear;
    }

    function pause() external onlyOwner {
        _pause();
    }

    function unpause() external onlyOwner {
        _unpause();
    }

    event UserPaid(address indexed user, uint256 amount);
    event UserPaidPublic(address indexed user, uint256 amount);
    event UserClaimed(address indexed user, uint256 amount);
    event Refunded(address indexed user, uint256 amount);

    // Admin functions //

    function withdrawTokens(address to) external onlyOwner {
        uint256 leftover = IERC20(token).balanceOf(address(this));
        IERC20(token).safeTransfer(to, leftover);
    }

    function withdrawDollars(address to) external onlyOwner {
        uint256 _balance = IERC20(paymentToken).balanceOf(address(this));
        IERC20(paymentToken).safeTransfer(to, _balance);
    }

    function emergencyWithdraw(address to) public onlyOwner {
        uint256 _balance = IERC20(token).balanceOf(address(this));
        if (_balance > 0) {
            IERC20(token).transfer(to, _balance);
        }
        _balance = IERC20(paymentToken).balanceOf(address(this));
        if (_balance > 0) {
            IERC20(paymentToken).transfer(to, _balance);
        }
        _balance = address(this).balance;
        if (_balance > 0) {
            (bool success,) = payable(to).call{value: _balance}("");
            if (!success) revert TransferFailed();
        }
    }

    function setLinearParams(
        uint32 startDate,
        uint32 duration,
        uint32 refundPeriodStart,
        uint32 refundPeriodEnd,
        uint8 percentageUnlocked
    ) external onlyOwner {
        if (!isLinear) revert LinearVestingDisabled();
        _startDate = startDate;
        _duration = duration;
        _refundPeriodStart = refundPeriodStart;
        _refundPeriodEnd = refundPeriodEnd;
        claimPercentage = percentageUnlocked;
    }

    function setRefundPeriod(uint32 refundPeriodStart, uint32 refundPeriodEnd) external onlyOwner {
        _refundPeriodStart = refundPeriodStart;
        _refundPeriodEnd = refundPeriodEnd;
    }

    function notifyVesting(uint8 percentage) external onlyOwner {
        claimPercentage = percentage;
    }

    function setToken(address _token, uint8 _decimal) external onlyOwner {
        token = _token;
        decimal = _decimal;
    }

    // Private functions //

    function normalize(uint256 _amount) private view returns (uint256) {
        _amount = (_amount / price) * 10**priceDecimal;
        return (_amount * 10**decimal) / 1e18;
    }

    // Public view functions //

    function claimableAllocation(address _user)
    public
    view
    returns (uint256 _claimable)
    {
        _claimable =
            ((paidAmounts[_user] * claimPercentage) / 10000) -
            claimedAmounts[_user];
    }

    function claimableTokens(address _user)
    public
    view
    returns (uint256 _claimable)
    {
        _claimable = normalize(claimableAllocation(_user));
    }

    function deserved(uint256 _amount) public view returns (uint256 _deserved) {
        if (_startDate == 0) {
            _deserved = (_amount * claimPercentage * 1e5) / 1e7;
        } else {
            uint256 _now = block.timestamp > _startDate + _duration
                ? _startDate + _duration
                : block.timestamp;
            uint256 timePast = (_now - _startDate);
            uint256 scaledAmount = ((timePast * _amount * (1e7 - claimPercentage * 1e5)) / _duration) / 1e7;
            _deserved = scaledAmount + (_amount * claimPercentage * 1e5) / 1e7;
        }
    }

    function deservedByUser(address _user) public view returns (uint256 _deserved) {
        _deserved = deserved(normalize(paidAmounts[_user]));
    }

    function isRefunded(address _user) public view returns (bool){
        return refunded[_user];
    }

    // Public mutative functions //

    function askForRefund() external nonReentrant whenNotPaused {
        if (claimedTokens[_msgSender()] > 0 || claimedAmounts[_msgSender()] > 0) revert AlreadyClaimed();
        if (isRefunded(_msgSender())) revert AlreadyRefunded();
        if (_refundPeriodStart >= block.timestamp || _refundPeriodStart == 0) revert RefundPeriodNotStarted();
        if (_refundPeriodEnd <= block.timestamp) revert RefundPeriodEnded();

        uint256 _amount = paidAmounts[_msgSender()];
        if (_amount == 0) revert AmountIsZero();

        refunded[_msgSender()] = true;
        IERC20(paymentToken).safeTransfer(_msgSender(), _amount);
        emit Refunded(_msgSender(), _amount);
    }

    function claimTokens() external nonReentrant whenNotPaused {
        if (isRefunded(_msgSender())) revert AlreadyRefunded();
        if (isLinear) {
            _claimTokensLinear();
        } else {
            _claimTokens();
        }
    }

    function _claimTokens() private {
        uint256 _amount = claimableTokens(_msgSender());
        uint256 amount_ = claimableAllocation(_msgSender());
        if (_amount == 0) revert AmountIsZero();
        IERC20(token).safeTransfer(_msgSender(), _amount);
        claimedAmounts[_msgSender()] += amount_;
        claimedTokens[_msgSender()] += _amount;
        totalClaimed += _amount;
        emit UserClaimed(_msgSender(), _amount);
    }

    function _claimTokensLinear() private {
        uint256 _deserved = deservedByUser(_msgSender());
        uint256 tokensToClaim = _deserved - claimedTokens[_msgSender()];
        if (tokensToClaim == 0) revert AllTokensClaimed();
        if (totalClaimed + tokensToClaim > normalize(totalDollars)) revert NotEnoughTokens();
        claimedTokens[_msgSender()] += tokensToClaim;
        totalClaimed += tokensToClaim;
        IERC20(token).safeTransfer(_msgSender(), tokensToClaim);
        emit UserClaimed(_msgSender(), tokensToClaim);
    }
}
