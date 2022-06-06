// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract MultiSendCustom {
  function bulkSendEth(address _token, address[] memory addresses, uint256[] memory amounts) public {
    require(addresses.length == amounts.length, "Wrong input lengths");
    for (uint i=0; i < addresses.length; i++){
      IERC20(_token).transferFrom(msg.sender, addresses[i], amounts[i]);
    }
  }
}