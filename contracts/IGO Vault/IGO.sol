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
    uint256 private _totalSupply;
    address public vault;
    uint256 public rewardsDuration = 10 days;
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
    event Staked(address indexed user, uint256 amount);
    event Withdrawn(address indexed user, uint256 amount);
    event RewardPaid(address indexed user, uint256 reward);

    function balanceOf(address _account) public returns (uint256) {
        return ISpinVault(vault).vaultBalanceOf(_account);
    }

    function lastTimeRewardApplicable() public view returns (uint256) {
        return block.timestamp < (startDate + rewardsDuration) ? block.timestamp : (startDate + rewardsDuration);
    }

    function rewardPerToken() public view returns (uint256) {
        if (_totalSupply == 0) {
            return rewardPerTokenStored;
        }
        return
            rewardPerTokenStored + 
                (lastTimeRewardApplicable() - lastUpdateTime) * rewardRate * 1e18 / _totalSupply;
    }

    function earned(address account) public returns (uint256) {
        return (ISpinVault(vault).vaultBalanceOf(account) * (rewardPerToken() - userRewardPerTokenPaid[account]) / 1e18) + (rewards[account]);
    }

    function increaseSupply(address account, uint256 amount) external nonReentrant updateReward(account) {
        require(amount > 0, "Cannot stake 0");
        _totalSupply = _totalSupply.add(amount);
    }

    function decreaseSupply(uint256 amount) public nonReentrant updateReward(msg.sender) {
        require(amount > 0, "Cannot withdraw 0");
        _totalSupply = _totalSupply.sub(amount);
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