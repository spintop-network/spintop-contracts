// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "../Libraries/SafeBEP20.sol";
import "./ISpinVault.sol";

interface IIGO {
    event DistributionStart(uint256 reward);
    event RewardPaid(address indexed user, uint256 reward);

    function lastTimeRewardApplicable() external view returns (uint256);
    function rewardPerToken() external view returns (uint256); 
    function earned(address account) external view returns (uint256); 
    function start (uint256 reward) external; 
    function updateWithVault(address account) external; 
    function checkState () external view returns(bool);
}