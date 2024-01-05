// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

interface IIGO {
    // Events
    event ClaimContract(
        address vault,
        address igo,
        uint256 totalDollars,
        address paymentToken,
        uint256 price,
        uint256 priceDecimal,
        uint256 multiplier
    );

    event DistributionStart(uint256 reward);
    event RewardPaid(address indexed user, uint256 reward);

    // Public and External Functions
    function emergencyWithdraw() external;
    function withdrawFunds(uint256 token) external;
    function notifyVesting(uint256 _percentage) external;
    function setToken(address _token, uint256 _decimal) external;
    function setPeriods(uint256 _allocationTime, uint256 _publicTime) external;
    function start() external;
    function setStateVault() external;
    function lastTimeRewardApplicable() external view returns (uint256);
    function totalRewardAdded() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function rewardPerToken() external view returns (uint256);
    function earned(address account) external view returns (uint256);
    function stake(address account, uint256 amount) external;
    function unstake(address account, uint256 amount) external;
    function setClaimContract(address _claimContract) external;

    // Getter Functions for Public Variables
    function gameName() external view returns (string memory);
    function IGOstate() external view returns (bool);
    function startDate() external view returns (uint256);
    function rewardRate() external view returns (uint256);
    function lastUpdateTime() external view returns (uint256);
    function rewardPerTokenStored() external view returns (uint256);
    function rewardsDuration() external view returns (uint256);
    function totalDollars() external view returns (uint256);
    function userRewardPerTokenPaid(address) external view returns (uint256);
    function rewards(address) external view returns (uint256);
    function _totalSupply() external view returns (uint256);
}
