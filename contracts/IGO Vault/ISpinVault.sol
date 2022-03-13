// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ISpinVault {
    function vaultBalanceOf(address _account) external returns(uint256);
}