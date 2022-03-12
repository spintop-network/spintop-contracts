// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ISpinStakable {
    function totalStaked() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function lastTimeRewardApplicable() external view returns (uint256);
    function rewardPerToken() external view returns (uint256);
    function earned(address account) external view returns (uint256);
    function getRewardForDuration() external view returns (uint256);
    function totalRewardAdded() external view returns (uint256);
    function unstakable(address account) external view returns (bool);
    function stake(uint256 amount) external;
    function unstake(uint256 amount) external;
    function getReward() external;
    function exit() external;
    function notifyRewardAmount(uint256 reward) external;
    function recoverERC20(address tokenAddress, uint256 tokenAmount) external;
    function setRewardsDuration(uint256 _rewardsDuration) external;
    function setUnlockDuration(uint256 _unlockDuration) external;

    event RewardAdded(uint256 reward);
    event Staked(address indexed user, uint256 amount);
    event Withdrawn(address indexed user, uint256 amount);
    event RewardPaid(address indexed user, uint256 reward);
    event RewardsDurationUpdated(uint256 newDuration);
    event Recovered(address token, uint256 amount);
    event UnlockDurationUpdated(uint256 newDuration);
}