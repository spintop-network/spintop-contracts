// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/utils/Context.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "../Interfaces/IIGO.sol";

/// @title Spinstarter IGO Claim
/// @author Spintop.Network
/// @notice Pay for and claim earned tokens.
/// @dev 'Dollars' symbolize underlying payment tokens. Assumed 18 decimal.
contract IGOClaim is Context, Pausable, Ownable, ReentrancyGuard {
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
    uint256 public allocationTime = 6 hours;
    uint256 public publicTime = 24 hours;
    uint256 public claimPercentage = 0;
    uint256 public totalPaid;
    uint256 public totalClaimed;
    mapping(address => uint256) public paidAmounts;
    mapping(address => uint256) public paidPublic;
    mapping(address => uint256) public claimedAmounts;
    mapping(address => uint256) public claimedTokens;

    constructor(
        address _vault,
        address _igo,
        uint256 _totalDollars,
        address _paymentToken,
        uint256 _price,
        uint256 _priceDecimal,
        uint256 _multiplier
    ) {
        vault = _vault;
        igo = _igo;
        totalDollars = _totalDollars;
        paymentToken = _paymentToken;
        price = _price;
        priceDecimal = _priceDecimal;
        multiplier = _multiplier;
    }

    function initialize(uint256 _allocationStartDate)
        external
        onlyOwner
        whenPaused
    {
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
    event UserClaimed(address indexed user, uint256 amount);

    // Admin functions //

    function withdrawTokens() external onlyOwner withdrawTimer {
        require(
            block.timestamp >
                (allocationStartDate + allocationTime + publicTime)
        );
        uint256 leftover = IERC20(token).balanceOf(address(this));
        IERC20(token).safeTransfer(tx.origin, leftover);
    }

    function withdrawDollars() external onlyOwner {
        require(totalPaid > 0, "Can not withdraw 0 amount.");
        IERC20(paymentToken).safeTransfer(tx.origin, totalPaid);
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
            claimedAmounts[_msgSender()];
    }

    function claimableTokens(address _user)
        public
        view
        returns (uint256 _claimable)
    {
        _claimable = normalize(claimableAllocation(_user));
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
        emit UserPaid(_msgSender(), _amount);
    }

    function claimTokens() external nonReentrant whenNotPaused {
        uint256 _amount = claimableTokens(_msgSender());
        uint256 amount_ = claimableAllocation(_msgSender());
        require(_amount > 0);
        IERC20(token).safeTransfer(_msgSender(), _amount);
        claimedAmounts[_msgSender()] += amount_;
        claimedTokens[_msgSender()] += _amount;
        totalClaimed += _amount;
        emit UserClaimed(_msgSender(), _amount);
    }
}
