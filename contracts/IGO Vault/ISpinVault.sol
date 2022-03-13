// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ISpinVault {
    function balanceOf(address _account) external view returns(uint256);
    function balance() external view returns (uint);
}