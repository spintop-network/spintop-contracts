// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./IGOClaim.sol";
import "../Libraries/SafeBEP20.sol";
import "../Interfaces/ISpinVault.sol";

contract IGO is Ownable, ReentrancyGuard {
    using SafeBEP20 for IBEP20;
    
    string public gameName;
    uint256 public startDate;
    uint256 public rewardRate;
    uint256 public lastUpdateTime;
    uint256 public rewardPerTokenStored;
    address public vault;
    IGOClaim public claimContract;
    uint256 public rewardsDuration = 10 minutes;
    mapping(address => uint256) public userRewardPerTokenPaid;
    mapping(address => uint256) public rewards;

    constructor(
        string memory _gameName,
        address _vault,
        uint256 _startDate,
        uint256 _totalDollars,
        uint256 _price,
        address _paymentToken
    ) {
        gameName = _gameName;
        vault = _vault;
        startDate = _startDate;
        claimContract = new IGOClaim(
            vault, 
            address(this),
            _totalDollars,
            _price,
            _paymentToken);
    }
    
    modifier updateReward(address account) {
        rewardPerTokenStored = rewardPerToken();
        lastUpdateTime = lastTimeRewardApplicable();
        if (account != address(0)) {
            rewards[account] = earned(account);
            userRewardPerTokenPaid[account] = rewardPerTokenStored;
        }
        _;
    }
    
    modifier onlyVault {
        require(_msgSender() == vault, "Only vault.");
        _;
    }

    event DistributionStart(uint256 reward);
    event RewardPaid(address indexed user, uint256 reward);

    function lastTimeRewardApplicable() public view returns (uint256) {
        return block.timestamp < (startDate + rewardsDuration) ? block.timestamp : (startDate + rewardsDuration);
    }

    function totalSupply() internal view returns (uint256) {
        return ISpinVault(vault).balance();
    }

    function rewardPerToken() public view returns (uint256) {
        if (totalSupply() == 0) {
            return rewardPerTokenStored;
        }
        return rewardPerTokenStored + 
                ((lastTimeRewardApplicable() - lastUpdateTime) * rewardRate * 1e18 / totalSupply());
    }

    function earned(address account) public view returns (uint256) {
        uint256 _balance = ISpinVault(vault).balanceOf(account);
        return _balance * (rewardPerToken() - userRewardPerTokenPaid[account]) / 1e18 + rewards[account];
    }

    function consume(address _account) public {
        rewards[_account] = 0;
    }

    function start (uint256 reward) public {
        rewardRate = reward / rewardsDuration;
        emit DistributionStart(reward);
    }

    function updateWithVault(address account) external {
        rewardPerTokenStored = rewardPerToken();
        lastUpdateTime = lastTimeRewardApplicable();
        if (account != address(0)) {
            rewards[account] = earned(account);
            userRewardPerTokenPaid[account] = rewardPerTokenStored;
        }
    }

    function checkState () external view returns(bool) {
        return block.timestamp < startDate + rewardsDuration;
    }
}