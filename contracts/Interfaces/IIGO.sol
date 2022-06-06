// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IIGO {
    event DistributionStart(uint256 reward);
    event RewardPaid(address indexed user, uint256 reward);

    function lastTimeRewardApplicable() external view returns (uint256);
    function rewardPerToken() external view returns (uint256); 
    function earned(address account) external view returns (uint256); 
    function start () external; 
    function updateWithVault(address account) external; 
    function checkState () external view returns(bool);
    function claimContract() external returns(address);
}