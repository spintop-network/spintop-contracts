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

    address private vault;
    address public paymentToken;
    address public igo;
    address public token;
    uint256 public decimal;
    uint256 public allocationStartDate;
    uint256 public totalDollars;
    uint256 public price;
    uint256 public priceDecimal;
    uint256 public multiplier;
    uint256 public allocationTime;
    uint256 public publicTime;
    uint256 public claimPercentage;
    uint256 public totalPaid;
    uint256 public totalClaimed;
    bool public isLinear;
    uint256 public _startDate;
    uint256 public _duration;
    uint256 public _refundPeriodStart;
    uint256 public _refundPeriodEnd;
    mapping(address => bool) public refunded;
    mapping(address => uint256) public paidAmounts;
    mapping(address => uint256) public paidPublic;
    mapping(address => uint256) public claimedAmounts;
    mapping(address => uint256) public claimedTokens;

    function initialize(
        address _vault,
        address _igo,
        uint256 _totalDollars,
        address _paymentToken,
        uint256 _price,
        uint256 _priceDecimal,
        uint256 _multiplier,
        bool _isLinear,
        address initialOwner
    ) initializer public {
        __Ownable_init(initialOwner);
        allocationTime = 6 hours;
        publicTime = 24 hours;
        claimPercentage = 0;
        vault = _vault;
        igo = _igo;
        totalDollars = _totalDollars;
        paymentToken = _paymentToken;
        price = _price;
        priceDecimal = _priceDecimal;
        multiplier = _multiplier;
        isLinear = _isLinear;
        _pause();
    }

    function setAllocationStartDate(uint256 _allocationStartDate) external onlyOwner whenPaused {
        allocationStartDate = _allocationStartDate;
    }

    function pause() external onlyOwner {
        _pause();
    }

    function unpause() external onlyOwner {
        _unpause();
    }

    modifier allocationTimer() {
        require(
            block.timestamp > allocationStartDate,
            "Allocation has not started yet."
        );
        require(
            block.timestamp <= (allocationStartDate + allocationTime),
            "Allocation has ended."
        );
        _;
    }

    modifier publicTimer() {
        require(
            block.timestamp > (allocationStartDate + allocationTime),
            "Public sale has not started yet."
        );
        require(
            block.timestamp <=
                (allocationStartDate + allocationTime + publicTime),
            "Public sale has ended."
        );
        _;
    }

    modifier withdrawTimer() {
        require(
            block.timestamp >
                (allocationStartDate + allocationTime + publicTime),
            "IGO has not ended yet."
        );
        _;
    }

    event ClaimUnlocked(address indexed igo);
    event UserPaid(address indexed user, uint256 amount);
    event UserPaidPublic(address indexed user, uint256 amount);
    event UserClaimed(address indexed user, uint256 amount);
    event Refunded(address indexed user, uint256 amount);

    // Admin functions //

    function withdrawTokens() external onlyOwner withdrawTimer {
        uint256 leftover = IERC20(token).balanceOf(address(this));
        IERC20(token).safeTransfer(tx.origin, leftover);
    }

    function withdrawDollars() external onlyOwner {
        uint256 _balance = IERC20(paymentToken).balanceOf(address(this));
        IERC20(paymentToken).safeTransfer(tx.origin, _balance);
    }

    function emergencyWithdraw() public onlyOwner {
        uint256 _balance = IERC20(token).balanceOf(address(this));
        if (_balance > 0) {
            IERC20(token).transfer(tx.origin, _balance);
        }
        _balance = IERC20(paymentToken).balanceOf(address(this));
        if (_balance > 0) {
            IERC20(paymentToken).transfer(tx.origin, _balance);
        }
        _balance = address(this).balance;
        if (_balance > 0) {
            (bool success,) = payable(tx.origin).call{value: _balance}("");
            require(success, "Transfer failed.");
        }
    }

    function setLinearParams(
        uint256 startDate,
        uint256 duration,
        uint256 refundPeriodStart,
        uint256 refundPeriodEnd,
        uint256 percentageUnlocked
    ) external onlyOwner {
        require(isLinear, "Linear vesting is disabled.");
        _startDate = startDate;
        _duration = duration;
        _refundPeriodStart = refundPeriodStart;
        _refundPeriodEnd = refundPeriodEnd;
        claimPercentage = percentageUnlocked;
    }

    function notifyVesting(uint256 percentage) external onlyOwner {
        claimPercentage = percentage;
    }

    function setPeriods(uint256 _allocationTime, uint256 _publicTime)
        external
        onlyOwner
    {
        allocationTime = _allocationTime;
        publicTime = _publicTime;
    }

    function setToken(address _token, uint256 _decimal) external onlyOwner {
        token = _token;
        decimal = _decimal;
    }

    // Private functions //

    function normalize(uint256 _amount) private view returns (uint256) {
        _amount = (_amount / price) * 10**priceDecimal;
        return (_amount / 1e18) * 10**decimal;
    }

    // Public view functions //

    function getState() external view returns (uint256) {
        uint256 allocPeriod = allocationStartDate + allocationTime;
        if (block.timestamp <= allocPeriod) {
            return 0;
        } else if (
            block.timestamp > allocPeriod &&
            block.timestamp <= allocPeriod + publicTime
        ) {
            return 1;
        } else {
            return 2;
        }
    }

    function tokensLeft() external view returns (uint256 tokens) {
        tokens = IERC20(token).balanceOf(address(this));
    }

    function maxPublicBuy(address _user)
        public
        view
        returns (uint256 _buyable)
    {
        _buyable = deservedAllocation(_user) * multiplier;
    }

    function deservedAllocation(address _user)
        public
        view
        returns (uint256 _deserved)
    {
        _deserved = (IIGO(igo).earned(_user));
    }

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

    // scale up by 1e4
    function percentageDeserved() public view returns (uint256 percentage) {
        uint256 _now = block.timestamp > _startDate + _duration
            ? _startDate + _duration
            : block.timestamp;
        uint256 timePast = (_now - _startDate) * 1e12;
        uint256 scaledPercentage = (timePast / _duration / 1e10) * (100 - claimPercentage);
        if (_startDate == 0){
            percentage = claimPercentage * 1e2;
        } else {
            percentage = claimPercentage * 1e2 + scaledPercentage;
        }
    }

    // scale down by 1e4
    function deserved(uint256 _amount) public view returns (uint256 _deserved) {
        uint256 _percentage = percentageDeserved();
        _deserved = (_percentage * _amount) / 1e4;
    }

    function isRefunded(address _user) public view returns (bool){
        return refunded[_user];
    }

    // Public mutative functions //

    function payForTokens(uint256 _amount)
        external
        nonReentrant
        allocationTimer
        whenNotPaused
    {
        require(_amount > 0);
        uint256 deserved = deservedAllocation(_msgSender());
        uint256 paid = paidAmounts[_msgSender()];
        require(_amount <= (deserved - paid));
        IERC20(paymentToken).safeTransferFrom(
            _msgSender(),
            address(this),
            _amount
        );
        paidAmounts[_msgSender()] += _amount;
        totalPaid += _amount;
        emit UserPaid(_msgSender(), _amount);
    }

    function payForTokensPublic(uint256 _amount)
        external
        nonReentrant
        publicTimer
        whenNotPaused
    {
        require(deservedAllocation(_msgSender()) > 0);
        require(_amount <= maxPublicBuy(_msgSender()));
        require((_amount + totalPaid) <= totalDollars);
        require(
            (paidPublic[_msgSender()] + _amount) <=
                (deservedAllocation(_msgSender()) * multiplier)
        );
        IERC20(paymentToken).safeTransferFrom(
            _msgSender(),
            address(this),
            _amount
        );
        paidAmounts[_msgSender()] += _amount;
        paidPublic[_msgSender()] += _amount;
        totalPaid += _amount;
        emit UserPaidPublic(_msgSender(), _amount);
    }

    function askForRefund() external nonReentrant whenNotPaused {
        require(claimedTokens[_msgSender()] == 0 && claimedAmounts[_msgSender()] == 0, "Tokens are claimed.");
        require(isRefunded(_msgSender()) == false, "Already refunded.");
        require(_refundPeriodStart < block.timestamp && block.timestamp < _refundPeriodEnd , "Refunds are ended.");

        uint256 _amount = paidAmounts[_msgSender()];
        require(_amount > 0, "Nothing to refund.");

        refunded[_msgSender()] = true;
        IERC20(paymentToken).safeTransfer(_msgSender(), _amount);
        emit Refunded(msg.sender, _amount);
    }

    function claimTokens() external nonReentrant whenNotPaused {
        require(isRefunded(_msgSender()) == false, "Refund requested.");
        if (isLinear) {
            _claimTokensLinear();
        } else {
            _claimTokens();
        }
    }

    function _claimTokens() private {
        uint256 _amount = claimableTokens(_msgSender());
        uint256 amount_ = claimableAllocation(_msgSender());
        require(_amount > 0);
        IERC20(token).safeTransfer(_msgSender(), _amount);
        claimedAmounts[_msgSender()] += amount_;
        claimedTokens[_msgSender()] += _amount;
        totalClaimed += _amount;
        emit UserClaimed(_msgSender(), _amount);
    }

    function _claimTokensLinear() private {
        require(block.timestamp > _startDate && _duration > 0, "Linear vesting is not started.");
        uint256 _deserved = deserved(normalize(paidAmounts[_msgSender()]));
        uint256 tokensToClaim = _deserved - claimedTokens[_msgSender()];
        require(tokensToClaim > 0, "You can't claim more tokens.");
        require(
            totalClaimed + tokensToClaim <= normalize(totalDollars),
            "No tokens left."
        );
        claimedTokens[_msgSender()] += tokensToClaim;
        totalClaimed += tokensToClaim;
        IERC20(token).safeTransfer(_msgSender(), tokensToClaim);
        emit UserClaimed(_msgSender(), tokensToClaim);
    }
}
