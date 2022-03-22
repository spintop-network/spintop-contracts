// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/utils/Context.sol";
import "../Interfaces/IIGO.sol";

// 'Dollars' symbolize underlying payment tokens. Not necessarily USD.
contract IGOClaim is Context, ReentrancyGuard {
    using SafeERC20 for IERC20;

    address private vault;
    address public paymentToken;
    address public igo;
    address public token;

    uint256 public allocationStartDate;
    uint256 public vestingStartDate;
    uint256 public totalDollars;

    uint256 public allocationTime = 6 hours;
    uint256 public fcfsTime = 24 hours;
    uint256 public claimPercentage = 0;
    uint256 public maxPublicBuy = 1000e18;
    bool public state = false;

    mapping(address => uint256) public paidAmounts;
    mapping(address => uint256) public claimedAmounts;
    uint256 public totalPaid;
    uint256 public totalClaimed;

    constructor (
        address _vault, 
        address _igo, 
        uint256 _totalDollars, 
        address _paymentToken, 
        uint256 _allocationStartDate) {
        vault = _vault;
        igo = _igo;
        totalDollars = _totalDollars;
        paymentToken = _paymentToken;
        allocationStartDate = _allocationStartDate;
    }
    
    modifier onlyVault {
        require(_msgSender() == vault, "Only Vault.");
        _;
    }

    modifier allocationTimer {
        require(block.timestamp <= (allocationStartDate + allocationTime), "Allocation has not started yet.");
        _;
    }

    modifier publicTimer {
        require(block.timestamp > (allocationStartDate + allocationTime), "Public sale has not started yet.");
        require(block.timestamp <= (allocationStartDate + allocationTime + fcfsTime), "FCFS has not started yet.");
        _;
    }

    modifier vestingTimer {
        require(block.timestamp > vestingStartDate, "Vesting has not started yet.");
        _;
    }

    event ClaimUnlocked(address indexed igo);
    event UserPaid(address indexed user, uint256 amount);
    event UserClaimed(address indexed user, uint256 amount);

    function deservedAllocation (address _user) public view returns (uint256 _deserved) {
        _deserved = (IIGO(igo).earned(_user));
    }

    function claimableAllocation (address _user) public view returns (uint256 _claimable) {
        _claimable = (paidAmounts[_user] * claimPercentage / 100) - claimedAmounts[_msgSender()];
    }
    
    function notifyVesting (uint256 percentage) public onlyVault {
        claimPercentage = percentage;
        vestingStartDate = block.timestamp;
    }

    function payForTokens (uint256 _amount) public nonReentrant allocationTimer { // timed 24h
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

    function payForTokensPublic (uint256 _amount) public nonReentrant publicTimer {
        require(paidAmounts[_msgSender()] > 0, "Must be allocated before.");
        require(_amount < maxPublicBuy, "Must be lower than allowed public allocation.");
        IERC20(paymentToken).safeTransferFrom(_msgSender(), address(this), _amount);
        paidAmounts[_msgSender()] += _amount;
    }

    function claimTokens(uint256 _amount) public nonReentrant vestingTimer {
        require(_amount > 0, "Can't do zero");
        if (_amount <= claimableAllocation(_msgSender())) {
            IERC20(token).safeTransfer(_msgSender(), _amount);
            claimedAmounts[_msgSender()] += _amount;
            totalClaimed += _amount;
            emit UserClaimed(_msgSender(), _amount);
        }  
    }
}