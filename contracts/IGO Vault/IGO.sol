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
    string public gameSymbol;
    uint256 public startDate = 0;
    uint256 public rewardRate = 0;
    uint256 public rewardsDuration = 10 days;
    uint256 public reward_amount = 10000;
    uint256 public lastUpdateTime;
    uint256 public rewardPerTokenStored;
    uint256 private _totalSupply;
    address public vault;
    mapping(address => uint256) public userRewardPerTokenPaid;
    mapping(address => uint256) public rewards;

    constructor(
        string memory _gameName,
        string memory _gameSymbol,
        address _rewardsToken,
        address _vault
    ) {
        gameName = _gameName;
        gameSymbol = _gameSymbol;
        rewardsToken = IBEP20(_rewardsToken);
        vault = _vault;
    }

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
            rewardPerTokenStored.add(
                lastTimeRewardApplicable().sub(lastUpdateTime).mul(rewardRate).mul(1e18).div(_totalSupply)
            );
    }

    function earned(address account) public returns (uint256) {
        return ISpinVault(vault).vaultBalanceOf(account).mul(rewardPerToken().sub(userRewardPerTokenPaid[account])).div(1e18).add(rewards[account]);
    }

    function getRewardForDuration() external view returns (uint256) {
        return rewardRate.mul(rewardsDuration);
    }
    
    function stake(address account, uint256 amount) external nonReentrant updateReward(account) {
        require(amount > 0, "Cannot stake 0");
        _totalSupply = _totalSupply.add(amount);
    }

    function unstake(uint256 amount) public nonReentrant updateReward(msg.sender) {
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

    function update(address account) external {
        rewardPerTokenStored = rewardPerToken();
        lastUpdateTime = lastTimeRewardApplicable();
        if (account != address(0)) {
            rewards[account] = earned(account);
            userRewardPerTokenPaid[account] = rewardPerTokenStored;
        }
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

    event RewardAdded(uint256 reward);
    event Staked(address indexed user, uint256 amount);
    event Withdrawn(address indexed user, uint256 amount);
    event RewardPaid(address indexed user, uint256 reward);
    event RewardsDurationUpdated(uint256 newDuration);
    event Recovered(address token, uint256 amount);
    event UnlockDurationUpdated(uint256 newDuration);
}