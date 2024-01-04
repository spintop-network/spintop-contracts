// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.23;

interface IIGOLinearVesting {
    // Events
    event RefundRequested(address indexed user, uint256 amount);

    // Public and External Functions
    function start() external;
    function claim(uint256 amount, bytes32[] calldata proof) external;
    function isRefundRequested(address _user) external view returns (bool);
    function percentageDeserved() external view returns (uint256 percentage);
    function deserved(uint256 _amount) external view returns (uint256 _deserved);
    function askForRefund(uint256 _amount, bytes32[] calldata proof) external;
    function emergencyWithdraw() external;
    function setParameters(
        bytes32 root,
        address tokenAddress,
        uint256 tokenAmount,
        uint256 firstClaimTime,
        uint256 duration,
        uint256 percentageUnlocked,
        uint256 refundPeriodStart,
        uint256 refundPeriodEnd
    ) external;

    // Getter Functions for Public Variables
    function _tokenAddress() external view returns (address);
    function _totalAmount() external view returns (uint256);
    function _duration() external view returns (uint256);
    function _startDate() external view returns (uint256);
    function _totalClaimed() external view returns (uint256);
    function _percentageUnlocked() external view returns (uint256);
    function _totalDollars() external view returns (uint256);
    function _firstClaimTime() external view returns (uint256);
    function _refundPeriodStart() external view returns (uint256);
    function _refundPeriodEnd() external view returns (uint256);
    function claimedTokens(address) external view returns (uint256);
    function refundRequest(address) external view returns (bool);
}
