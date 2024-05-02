// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/utils/ReentrancyGuardUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/ContextUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/PausableUpgradeable.sol";
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "../Interfaces/IIGO.sol";

/// @title Spinstarter IGO Claim
/// @author Spintop.Network
/// @notice Pay for and claim earned tokens.
/// @dev 'Dollars' symbolize underlying payment tokens. Assumed 18 decimal.
contract MerkledIGOClaim is Initializable, ContextUpgradeable, PausableUpgradeable, OwnableUpgradeable, ReentrancyGuardUpgradeable {
    using SafeERC20 for IERC20;

//    uint public totalRefunded;
    bytes32 public _root;
    uint32 public _startDate;
    uint32 public _duration;
    uint32 public _refundPeriodStart;
    uint32 public _refundPeriodEnd;
    uint32 public price;
    address public paymentToken;
    address public token;
    uint8 public decimal;
    uint8 public priceDecimal;
    uint8 public claimPercentage;
    bool public isLinear;
    uint8 public paymentTokenDecimal;
    mapping(address => bool) public refunded;
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
    error InvalidMerkleProof();

    function initialize(
        bytes32 _merkleRoot,
        uint32 _price,
        address _paymentToken,
        uint8 _paymentTokenDecimal,
        address initialOwner,
        uint8 _priceDecimal,
        bool _isLinear,
        address _token,
        uint8 tokenDecimal,
        uint8 _claimPercentage,
        uint32 refundPeriodStart,
        uint32 refundPeriodEnd
    ) initializer public {
        __Ownable_init(initialOwner);
        _root = _merkleRoot;
        paymentToken = _paymentToken;
        paymentTokenDecimal = _paymentTokenDecimal;
        price = _price;
        priceDecimal = _priceDecimal;
        isLinear = _isLinear;
        token = _token;
        decimal = tokenDecimal;
        claimPercentage = _claimPercentage;
        _refundPeriodStart = refundPeriodStart;
        _refundPeriodEnd = refundPeriodEnd;
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

    // Modifiers //

    modifier onlyValid(uint256 amount, bytes32[] calldata proof) {
        string memory payload = string(abi.encodePacked(_msgSender(), amount));
        if (!MerkleProof.verify(proof, _root, keccak256(abi.encodePacked(payload)))) revert InvalidMerkleProof();
        _;
    }

    // Admin functions //

    function withdrawTokens(address to, uint amount) external onlyOwner {
        if (amount == 0) {
            amount = IERC20(token).balanceOf(address(this));
        }
        IERC20(token).safeTransfer(to, amount);
    }

    function withdrawDollars(address to) external onlyOwner {
        uint256 _balance = IERC20(paymentToken).balanceOf(address(this));
        IERC20(paymentToken).safeTransfer(to, _balance);
    }

    function emergencyWithdraw(address to) external onlyOwner {
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

    function setPrice(uint32 _price, uint8 _priceDecimal) external onlyOwner {
        price = _price;
        priceDecimal = _priceDecimal;
    }

    function setPaymentToken (address _paymentToken, uint8 _paymentTokenDecimal) external onlyOwner {
        paymentToken = _paymentToken;
        paymentTokenDecimal = _paymentTokenDecimal;
    }

    function setMerkleRoot(bytes32 _merkleRoot) external onlyOwner {
        _root = _merkleRoot;
    }

    function setIsLinear(bool _isLinear) external onlyOwner {
        isLinear = _isLinear;
    }

    // Private functions //

    function normalize(uint256 _amount) private view returns (uint256) {
        _amount = (_amount / price) * 10**priceDecimal;
        return (_amount * 10**decimal) / 10**paymentTokenDecimal;
    }

    // Public view functions //

    function claimableAllocation(uint256 amount)
    public
    view
    returns (uint256 _claimable)
    {
        _claimable =
            ((amount * claimPercentage) / 10000);
    }

    function claimableTokens(address _user, uint256 amount)
    public
    view
    returns (uint256 _claimable)
    {
        _claimable = normalize(claimableAllocation(amount)) - claimedTokens[_user];
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

    function deservedByUser(uint256 amount) public view returns (uint256 _deserved) {
        _deserved = deserved(normalize(amount));
    }

    function isRefunded(address _user) public view returns (bool){
        return refunded[_user];
    }

    // Public mutative functions //

    function askForRefund(uint256 _amount, bytes32[] calldata proof) external nonReentrant whenNotPaused onlyValid(_amount, proof) {
        if (claimedTokens[_msgSender()] > 0) revert AlreadyClaimed();
        if (isRefunded(_msgSender())) revert AlreadyRefunded();
        if (_refundPeriodStart >= block.timestamp || _refundPeriodStart == 0) revert RefundPeriodNotStarted();
        if (_refundPeriodEnd <= block.timestamp) revert RefundPeriodEnded();

        if (_amount == 0) revert AmountIsZero();

        refunded[_msgSender()] = true;
        IERC20(paymentToken).safeTransfer(_msgSender(), _amount);
        emit Refunded(_msgSender(), _amount);
    }

    function claimTokens(uint256 amount, bytes32[] calldata proof) external nonReentrant whenNotPaused onlyValid(amount, proof) {
        if (isRefunded(_msgSender())) revert AlreadyRefunded();
        if (isLinear) {
            _claimTokensLinear(amount);
        } else {
            _claimTokens(amount);
        }
    }

    function _claimTokens(uint256 amount) private {
        uint256 _amount = claimableTokens(_msgSender(), amount);
        if (_amount == 0) revert AmountIsZero();
        IERC20(token).safeTransfer(_msgSender(), _amount);
        claimedTokens[_msgSender()] += _amount;
        emit UserClaimed(_msgSender(), _amount);
    }

    function _claimTokensLinear(uint256 amount) private {
        uint256 _deserved = deserved(normalize(amount));
        uint256 tokensToClaim = _deserved - claimedTokens[_msgSender()];
        if (tokensToClaim == 0) revert AllTokensClaimed();
        claimedTokens[_msgSender()] += tokensToClaim;
        IERC20(token).safeTransfer(_msgSender(), tokensToClaim);
        emit UserClaimed(_msgSender(), tokensToClaim);
    }
}
