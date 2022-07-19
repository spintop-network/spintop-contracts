// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ERC20Edited.sol";

contract ERC20DecimalMock is ERC20Edited {
    constructor(string memory _name, string memory _symbol)
        ERC20Edited(_name, _symbol)
    {
        _mint(msg.sender, 100000000000000);
    }
}
