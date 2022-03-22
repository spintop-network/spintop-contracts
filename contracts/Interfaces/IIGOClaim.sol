// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IIGOClaim {
    function unlockTokens (address _token, uint256 _decimal) external;
}