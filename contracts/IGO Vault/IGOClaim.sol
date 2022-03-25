// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/utils/Context.sol";
import "../Interfaces/IIGO.sol";

/// @title Spinstarter IGO Claim
/// @author Spintop.Network
/// @notice Pay for and claim earned tokens.
/// @dev 'Dollars' symbolize underlying payment tokens. Assumed 18 decimal.
contract IGOClaim is Context, ReentrancyGuard {
    using SafeERC20 for IERC20;

    address private vault;
    address public paymentToken;
    address public igo;
    address public token;
    uint256 public decimal;
    uint256 public allocationStartDate;
    uint256 public vestingStartDate;
    uint256 public totalDollars;
    uint256 public price;
    uint256 public multiplier;
    uint256 public allocationTime = 20 minutes;
    uint256 public publicTime = 20 minutes;
    uint256 public claimPercentage = 0;

    mapping(address => uint256) public paidAmounts;
    mapping(address => uint256) public claimedAmounts;
    uint256 public totalPaid;
    uint256 public totalClaimed;

    constructor (
        address _vault, 
        address _igo, 
        uint256 _totalDollars,
        address _paymentToken,
        uint256 _price, 
        uint256 _allocationStartDate) {
        vault = _vault;
        igo = _igo;
        totalDollars = _totalDollars;
        paymentToken = _paymentToken;
        price = _price;
        allocationStartDate = _allocationStartDate;
    }

    modifier onlyIGO {
        require(_msgSender() == igo, "Only IGO.");
        _;
    }

    modifier allocationTimer {
        require(block.timestamp > allocationStartDate, "Allocation has not started yet.");
        require(block.timestamp <= (allocationStartDate + allocationTime), "Allocation has ended.");
        _;
    }

    modifier publicTimer {
        require(block.timestamp > (allocationStartDate + allocationTime), "Public sale has not started yet.");
        require(block.timestamp <= (allocationStartDate + allocationTime + publicTime), "Public sale has ended.");
        _;
    }

    event ClaimUnlocked(address indexed igo);
    event UserPaid(address indexed user, uint256 amount);
    event UserClaimed(address indexed user, uint256 amount);

    // Admin functions // 

    function withdrawFunds () external onlyIGO {
        require(totalPaid > 0, "Can not withdraw 0 amount.");
        IERC20(paymentToken).safeTransfer(tx.origin, totalPaid);
    }

    function setPublicMultiplier (uint256 _multiplier) external onlyIGO {
        multiplier = _multiplier;
    }
    
    function notifyVesting (uint256 percentage) external onlyIGO {
        claimPercentage = percentage;
    }

    function setPeriods (uint256 _allocationTime, uint256 _publicTime) external onlyIGO {
        allocationTime = _allocationTime;
        publicTime = _publicTime;
    }

    function setToken (address _token, uint256 _decimal) external onlyIGO {
        token = _token;
        decimal = _decimal;
    }
    
    // Private functions //

    function normalize (uint256 _amount) private view returns(uint256) {
        return _amount * 10**decimal / 1e18;
    }

    // Public view functions //

    function maxPublicBuy(address _user) public view returns (uint256 _buyable) {
        _buyable = deservedAllocation(_user) * multiplier;
    }
    function deservedAllocation (address _user) public view returns (uint256 _deserved) {
        _deserved = (IIGO(igo).earned(_user));
    }

    function claimableAllocation (address _user) public view returns (uint256 _claimable) {
        _claimable = (paidAmounts[_user] * claimPercentage / 100) - claimedAmounts[_msgSender()];
    }

    // Public mutative functions //

    function payForTokens (uint256 _amount) external nonReentrant allocationTimer {
        require(_amount > 0, "Can't do zero");
        uint256 deserved = deservedAllocation(_msgSender());
        uint256 paid = paidAmounts[_msgSender()];
        if(_amount <= (deserved-paid)) {
            IERC20(paymentToken).safeTransferFrom(_msgSender(), address(this), _amount);
            paidAmounts[_msgSender()] += _amount;
            totalPaid += _amount;
            emit UserPaid(_msgSender(), _amount);     
        }
    }

    function payForTokensPublic (uint256 _amount) external nonReentrant publicTimer {
        require(deservedAllocation(_msgSender()) > 0, "Must be allocated before.");
        require(_amount < maxPublicBuy(_msgSender()), "Must be lower than allowed public allocation.");
        IERC20(paymentToken).safeTransferFrom(_msgSender(), address(this), _amount);
        paidAmounts[_msgSender()] += _amount;
        totalPaid += _amount;
        emit UserPaid(_msgSender(), _amount);     
    }

    function claimTokens(uint256 _amount) external nonReentrant {
        require(_amount > 0, "Can't do zero");
        if (_amount <= claimableAllocation(_msgSender())) {
            IERC20(token).safeTransfer(_msgSender(), normalize(_amount/price));
            claimedAmounts[_msgSender()] += _amount;
            totalClaimed += _amount;
            emit UserClaimed(_msgSender(), _amount);
        }
    }
}