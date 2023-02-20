// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LongArray {
    uint256 private length = 10000;

    constructor() {}

    function getArray() public view returns (uint256[] memory) {
        uint256[] memory array = new uint256[](length);
        for (uint256 i = 0; i < length; i++) {
            array[i];
        }
        return array;
    }
}
