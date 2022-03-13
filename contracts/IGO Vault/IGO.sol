// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "../Libraries/SafeBEP20.sol";
import "./ISpinVault.sol";

contract IGO is Ownable, ReentrancyGuard {
    using SafeMath for uint256;
    using SafeBEP20 for IBEP20;
    
    IBEP20 public rewardsToken;
    string public gameName;
    uint256 public startDate;
    uint256 public rewardRate;
    uint256 public lastUpdateTime;
    uint256 public rewardPerTokenStored;
    address public vault;
    uint256 public rewardsDuration = 10 minutes;
    mapping(address => uint256) public userRewardPerTokenPaid;
    mapping(address => uint256) public rewards;

    constructor(
        string memory _gameName,
        address _rewardsToken,
        address _vault,
        uint256 _startDate
    ) {
        gameName = _gameName;
        rewardsToken = IBEP20(_rewardsToken);
        vault = _vault;
        startDate = _startDate;
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
        uint256 _x = rewardPerTokenStored + 
                ((lastTimeRewardApplicable() - lastUpdateTime) * rewardRate * 1e18 / totalSupply());
        return _x;
            
    }

    function earned(address account) public view returns (uint256) {
        uint256 _balance = ISpinVault(vault).balanceOf(account);
        uint256 _earned = _balance * (rewardPerToken() - userRewardPerTokenPaid[account]) / 1e18 + rewards[account];
        return _earned;
    }

    function getReward() public nonReentrant updateReward(msg.sender) {
        uint256 reward = rewards[msg.sender];
        if (reward > 0) {
            rewards[msg.sender] = 0;
            rewardsToken.safeTransfer(msg.sender, reward);
            emit RewardPaid(msg.sender, reward);
        }
    }

    function start (uint256 reward) public {
        rewardRate = reward.div(rewardsDuration);
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