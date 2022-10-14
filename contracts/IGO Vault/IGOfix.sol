// // SPDX-License-Identifier: Unlicensed
// pragma solidity 0.8.0;

// import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
// import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";
// import "@openzeppelin/contracts/access/Ownable.sol";

// /**
//  * @title Merkelized Distributer
//  * @dev Single withdraw for all remaining tokens
//  */

// contract IGOLinearVesting is Ownable {
//     bytes32 private _root;
//     address public _tokenAddress;

//     mapping(address => bool) public claimedTokens;

//     constructor(
//         bytes32 root,
//         address tokenAddress
//     ) {
//         _root = root;
//         _tokenAddress = tokenAddress;
//     }

//     function claim(uint256 amount, bytes32[] calldata proof) external {
//         string memory payload = string(abi.encodePacked(msg.sender, amount));
//         require(
//             _verify(_leaf(payload), proof),
//             "Invalid Merkle Tree proof supplied."
//         );
//         require(claimedTokens[msg.sender], "You claimed your tokens already.")
//         IERC20(_tokenAddress).transfer(msg.sender, amount);
//         claimedTokens[msg.sender] = true;
//     }

//     function _leaf(string memory payload) internal pure returns (bytes32) {
//         return keccak256(abi.encodePacked(payload));
//     }

//     function _verify(bytes32 leaf, bytes32[] memory proof)
//         internal
//         view
//         returns (bool)
//     {
//         return MerkleProof.verify(proof, _root, leaf);
//     }

//     function emergencyWithdraw() public onlyOwner {
//         uint256 _balance = IERC20(_tokenAddress).balanceOf(address(this));
//         IERC20(_tokenAddress).transfer(owner(), _balance);
//     }
// }
