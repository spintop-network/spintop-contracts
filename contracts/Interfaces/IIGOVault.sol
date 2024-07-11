// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

interface IIGOVault {
    // Events

    // Public and External Functions

    // Getter Functions for Public Variables
    function blacklisted(address _user) external view returns (bool);
}