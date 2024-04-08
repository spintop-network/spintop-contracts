// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Release is Ownable {
    address public spin;
    bytes32 public root;
    mapping(address => uint256) public claimed;

    event Claim(address indexed sender, uint256 amount);

    constructor(address _spin) {
        spin = _spin;
    }

    function claim(uint256 _amount, bytes32[] memory _proof) public {
        require(_amount > 0, "Invalid amount");
        require(
            MerkleProof.verify(
                _proof,
                root,
                keccak256(abi.encodePacked(msg.sender, _amount))
            ),
            "Invalid merkle proof"
        );
        uint256 deserved = _amount - claimed[msg.sender];
        require(deserved > 0, "Already claimed");
        require(
            IERC20(spin).balanceOf(address(this)) >= deserved,
            "No balance"
        );
        claimed[msg.sender] += deserved;
        IERC20(spin).transfer(msg.sender, deserved);
        emit Claim(msg.sender, deserved);
    }

    function setRoot(bytes32 _root) public onlyOwner {
        root = _root;
    }
}
