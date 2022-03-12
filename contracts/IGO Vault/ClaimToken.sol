// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ClaimToken is ERC20 {

    constructor (string memory _name, string memory _symbol) ERC20(_name, _symbol){
        _mint(_msgSender(), 10**24);
    }
}