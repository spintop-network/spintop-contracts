// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract MultiSend {

  address public immutable SPIN = 0x6AA217312960A21aDbde1478DC8cBCf828110A67;
  function bulkSendEth(address[] memory addresses, uint256[] memory amounts) public {
    require(addresses.length == amounts.length, "Wrong input lengths");
    for (uint i=0; i < addresses.length; i++){
      IERC20(SPIN).transferFrom(msg.sender, addresses[i], amounts[i]);
    }
  }
}