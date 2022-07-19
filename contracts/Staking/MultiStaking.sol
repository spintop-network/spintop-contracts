// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "../Libraries/SafeBEP20.sol";
import "hardhat/console.sol";

/// @title Spintop Staking Rewards
/// @author Spintop.Network
/// @notice Staking contract with multiple token rewards.
/// @dev Owner doesn't have control over 'stakingToken', this includes if both staking and reward tokens are the same.
/// @dev Bonus token doesn't have it's own balance. It piggybacks onto rewards with ratio.
contract MultiStaking is Ownable, ReentrancyGuard {
    using SafeMath for uint256;
    using SafeBEP20 for IBEP20;

    /* ========== STATE VARIABLES ========== */

    IBEP20 public rewardsToken;
    IBEP20 public stakingToken;
    IBEP20 public bonusToken;

    uint256 public periodFinish = 0;
    uint256 public rewardRate = 0;
    uint256 public bonusRate = 0;
    uint256 public rewardsDuration = 30 days;
    uint256 public lastUpdateTime;
    uint256 public rewardPerTokenStored;
    uint256 private unlockDuration = 0;

    mapping(address => uint256) public userRewardPerTokenPaid;
    mapping(address => uint256) public rewards;

    uint256 private _totalSupply;
    mapping(address => uint256) private _balances;
    mapping(address => uint256) private _stakingTime;
    uint256 private reward_amount;
    uint256 private bonus_amount;

    /* ========== CONSTRUCTOR ========== */

    constructor(
        address _stakingToken,
        address _rewardsToken,
        address _bonusToken
    ) {
        rewardsToken = IBEP20(_rewardsToken);
        bonusToken = IBEP20(_bonusToken);
        stakingToken = IBEP20(_stakingToken);
    }

    /* ========== VIEWS ========== */

    function totalStaked() external view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) external view returns (uint256) {
        return _balances[account];
    }

    function lastTimeRewardApplicable() public view returns (uint256) {
        return block.timestamp < periodFinish ? block.timestamp : periodFinish;
    }

    function rewardPerToken() public view returns (uint256) {
        if (_totalSupply == 0) {
            return rewardPerTokenStored;
        }
        return
            rewardPerTokenStored.add(
                lastTimeRewardApplicable()
                    .sub(lastUpdateTime)
                    .mul(rewardRate)
                    .mul(1e18)
                    .div(_totalSupply)
            );
    }

    function earned(address account) public view returns (uint256) {
        return
            _balances[account]
                .mul(rewardPerToken().sub(userRewardPerTokenPaid[account]))
                .div(1e18)
                .add(rewards[account]);
    }

    function earnedBonus(address account) public view returns (uint256) {
        uint256 _ratio = getTokenRatio();
        console.log("Ratio:", _ratio);
        uint256 _earned = earned(account);
        return (_ratio * _earned) / 1e12;
    }

    function getRewardForDuration() external view returns (uint256) {
        return rewardRate.mul(rewardsDuration);
    }

    function totalRewardAdded() external view returns (uint256) {
        return reward_amount;
    }

    function totalBonusAdded() external view returns (uint256) {
        return bonus_amount;
    }

    function unstakable(address account) external view returns (bool) {
        if (_stakingTime[account] + unlockDuration <= block.timestamp) {
            return true;
        }
        return false;
    }

    // returns 1e4 ratio
    function getTokenRatio() public view returns (uint256 ratio) {
        console.log("Bonus amount:", bonus_amount);
        ratio = bonus_amount.mul(1e12).div(reward_amount);
    }

    /* ========== MUTATIVE FUNCTIONS ========== */

    function stake(uint256 amount)
        external
        nonReentrant
        updateReward(msg.sender)
    {
        require(amount > 0, "Cannot stake 0");
        _totalSupply = _totalSupply.add(amount);
        _balances[msg.sender] = _balances[msg.sender].add(amount);
        stakingToken.safeTransferFrom(msg.sender, address(this), amount);
        _stakingTime[msg.sender] = block.timestamp;
        emit Staked(msg.sender, amount);
    }

    function unstake(uint256 amount)
        public
        nonReentrant
        updateReward(msg.sender)
        isUnlocked(msg.sender)
    {
        require(amount > 0, "Cannot withdraw 0");
        _totalSupply = _totalSupply.sub(amount);
        _balances[msg.sender] = _balances[msg.sender].sub(amount);
        stakingToken.safeTransfer(msg.sender, amount);
        emit Withdrawn(msg.sender, amount);
    }

    function getReward() public nonReentrant updateReward(msg.sender) {
        uint256 reward = rewards[msg.sender];
        uint256 ratio = getTokenRatio();
        uint256 bonus = (reward * ratio) / 1e12;
        if (reward > 0) {
            rewards[msg.sender] = 0;
            rewardsToken.safeTransfer(msg.sender, reward);
            bonusToken.safeTransfer(msg.sender, bonus);
            emit RewardPaid(msg.sender, reward);
            emit BonusPaid(msg.sender, bonus);
        }
    }

    function exit() external {
        unstake(_balances[msg.sender]);
        getReward();
    }

    /* ========== RESTRICTED FUNCTIONS ========== */

    // Always needs to update the balance of the contract when calling this method
    function notifyRewardAmount(uint256 reward, uint256 bonus)
        external
        onlyOwner
        updateReward(address(0))
    {
        // bonus & reward share schedule
        if (block.timestamp >= periodFinish) {
            rewardRate = reward.div(rewardsDuration);
            bonusRate = bonus.div(rewardsDuration);
        } else {
            uint256 remaining = periodFinish.sub(block.timestamp);
            uint256 leftover = remaining.mul(rewardRate);
            uint256 bonusLeftover = remaining.mul(bonusRate);
            rewardRate = reward.add(leftover).div(rewardsDuration);
            bonusRate = bonus.add(bonusLeftover).div(rewardsDuration);
        }

        uint256 balance = rewardsToken.balanceOf(address(this));
        require(
            rewardRate <= balance.div(rewardsDuration),
            "Provided reward too high"
        );
        uint256 bonusBalance = bonusToken.balanceOf(address(this));
        require(
            bonusRate <= bonusBalance.div(rewardsDuration),
            "Provided bonus too high"
        );

        reward_amount += reward;
        bonus_amount += bonus;
        lastUpdateTime = block.timestamp;
        periodFinish = block.timestamp.add(rewardsDuration);
        emit RewardAdded(reward);
    }

    // Added to support recovering LP Rewards from other systems such as BAL to be distributed to holders
    function recoverERC20(address tokenAddress, uint256 tokenAmount)
        external
        onlyOwner
    {
        require(
            tokenAddress != address(stakingToken),
            "Cannot withdraw the staking token"
        );
        IBEP20(tokenAddress).safeTransfer(owner(), tokenAmount);
        emit Recovered(tokenAddress, tokenAmount);
    }

    function setRewardsDuration(uint256 _rewardsDuration) external onlyOwner {
        require(
            block.timestamp > periodFinish,
            "Previous rewards period must be complete before changing the duration for the new period"
        );
        rewardsDuration = _rewardsDuration;
        emit RewardsDurationUpdated(rewardsDuration);
    }

    function setUnlockDuration(uint256 _unlockDuration) external onlyOwner {
        unlockDuration = _unlockDuration;
        emit UnlockDurationUpdated(unlockDuration);
    }

    /* ========== MODIFIERS ========== */

    modifier isUnlocked(address account) {
        require(_stakingTime[account] + unlockDuration <= block.timestamp);
        _;
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

    /* ========== EVENTS ========== */

    event RewardAdded(uint256 reward);
    event Staked(address indexed user, uint256 amount);
    event Withdrawn(address indexed user, uint256 amount);
    event RewardPaid(address indexed user, uint256 reward);
    event BonusPaid(address indexed user, uint256 bonus);
    event RewardsDurationUpdated(uint256 newDuration);
    event Recovered(address token, uint256 amount);
    event UnlockDurationUpdated(uint256 newDuration);
}
