// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AnyswapCreate2Deployer {
  event Deployed(address addr, uint256 salt);
  address implementation;

  function implementationAddress () public view returns (address) {
    return implementation;
  }
function deploy(bytes memory _code, string memory _name, string memory _symbol, uint8 _decimals, address _underlying, address _vault, uint256 salt) public returns (address) {
    address addr;
    bytes memory code = abi.encodePacked(_code, abi.encode(_name,_symbol,_decimals,_underlying,_vault));

    assembly {
      addr := create2(0, add(code, 0x20), mload(code), salt)
      if iszero(extcodesize(addr)) {
        revert(0, 0)
      }
    }
    emit Deployed(addr, salt);
    implementation = addr;
    return addr;
  }
}