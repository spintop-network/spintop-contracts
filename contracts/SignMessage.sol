// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract SignMessage {
    // take the keccak256 hashed message from the getHash function above and input into this function
    // this function prefixes the hash above with \x19Ethereum signed message:\n32 + hash
    // and produces a new hash signature
    function getEthSignedHash(string memory str) public pure returns (bytes32) {
        bytes32 _messageHash = keccak256(abi.encodePacked(str));
        return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", _messageHash));
    }

    function getSignedHash(string memory str) public pure returns (bytes32) {
        bytes32 _messageHash = keccak256(abi.encodePacked(str));
        return _messageHash;
    }
    
}  