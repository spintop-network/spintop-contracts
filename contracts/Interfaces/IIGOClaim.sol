// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

interface IIGOClaim {
    // Events
    event ClaimUnlocked(address indexed igo);
    event UserPaid(address indexed user, uint256 amount);
    event UserClaimed(address indexed user, uint256 amount);

    // Public and External Functions
    function setAllocationStartDate(uint256 _allocationStartDate) external;
    function pause() external;
    function unpause() external;
    function emergencyWithdraw() external;
    function withdrawTokens() external;
    function withdrawDollars() external;
    function notifyVesting(uint256 percentage) external;
    function setPeriods(uint256 _allocationTime, uint256 _publicTime) external;
    function setMultiplier(uint256 _multiplier) external;
    function setToken(address _token, uint256 _decimal) external;
    function getState() external view returns (uint256);
    function tokensLeft() external view returns (uint256 tokens);
    function maxPublicBuy(address _user) external view returns (uint256 _buyable);
    function deservedAllocation(address _user) external view returns (uint256 _deserved);
    function claimableAllocation(address _user) external view returns (uint256 _claimable);
    function claimableTokens(address _user) external view returns (uint256 _claimable);
    function payForTokens(uint256 _amount) external;
    function payForTokensPublic(uint256 _amount) external;
    function claimTokens() external;
    function setLinearParams(
        uint256 startDate,
        uint256 duration,
        uint256 refundPeriodStart,
        uint256 refundPeriodEnd,
        uint256 percentageUnlocked
    ) external;
    function setRefundPeriod(uint256 refundPeriodStart, uint256 refundPeriodEnd) external;

    // Getter Functions for Public Variables
    function paymentToken() external view returns (address);
    function igo() external view returns (address);
    function token() external view returns (address);
    function decimal() external view returns (uint256);
    function allocationStartDate() external view returns (uint256);
    function totalDollars() external view returns (uint256);
    function price() external view returns (uint256);
    function priceDecimal() external view returns (uint256);
    function multiplier() external view returns (uint256);
    function allocationTime() external view returns (uint256);
    function publicTime() external view returns (uint256);
    function claimPercentage() external view returns (uint256);
    function totalPaid() external view returns (uint256);
    function totalClaimed() external view returns (uint256);
    function paidAmounts(address) external view returns (uint256);
    function paidPublic(address) external view returns (uint256);
    function claimedAmounts(address) external view returns (uint256);
    function claimedTokens(address) external view returns (uint256);
}
