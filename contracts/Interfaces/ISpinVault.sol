// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ISpinVault {
    function getUserStaked(address account) external view returns (uint256);
}
