// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.1;

import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "hardhat/console.sol";

/**
 * @title Merkelized Linear Vesting
 * @dev A token holder contract that can release its token balance gradually like a
 * typical vesting scheme.
 */

contract IGOLinearVesting is Ownable {
    bytes32 private _root;
    address public _tokenAddress;
    uint256 public _totalAmount;
    uint256 public _duration;
    uint256 public _startDate;
    uint256 public _totalClaimed;
    uint256 public _percentageUnlocked;
    uint256 public _totalDollars;
    uint256 public _firstClaimTime;
    mapping(address => uint256) public claimedTokens;
    mapping(address => bool) public refundRequest;
    constructor(
        bytes32 root,
        address tokenAddress,
        uint256 tokenAmount,
        uint256 totalDollars,
        uint256 firstClaimTime,
        uint256 duration,
        uint256 percentageUnlocked
    ){
        _root = root;
        _tokenAddress = tokenAddress;
        _totalAmount = tokenAmount;
        _duration = duration;
        _percentageUnlocked = percentageUnlocked;
        _totalDollars = totalDollars;
        _firstClaimTime = firstClaimTime;
    }
    function start() public onlyOwner {
        _startDate = block.timestamp;
    }
    function claim(uint256 amount, bytes32[] calldata proof) external {
        require(_firstClaimTime < block.timestamp, "Not time yet.");
        require(refundRequest[msg.sender] == false, "Refund requested.");
        string memory payload = string(abi.encodePacked(msg.sender, amount));
        require(
            _verify(_leaf(payload), proof),
            "Invalid Merkle Tree proof supplied."
        );
        uint256 _deserved = deserved(amount);
        uint256 tokensToClaim = _deserved - claimedTokens[msg.sender];
        require(tokensToClaim > 0, "You can't claim more tokens.");
        require(
            _totalClaimed + tokensToClaim <= _totalAmount,
            "No tokens left."
        );
        claimedTokens[msg.sender] += tokensToClaim;
        _totalClaimed += tokensToClaim;
        IERC20(_tokenAddress).transfer(msg.sender, tokensToClaim * 1e3);
    }
    // scale up by 1e4
    function percentageDeserved() public view returns (uint256 percentage) {
        uint256 _now = block.timestamp > _startDate + _duration
            ? _startDate + _duration
            : block.timestamp;
        uint256 timePast = (_now - _startDate) * 1e12;
        uint256 scaledPercentage = (timePast / _duration / 1e10) * 100;
        if (_startDate == 0){
            percentage = _percentageUnlocked * 1e2;
        } else {
        percentage = _percentageUnlocked * 1e2 + scaledPercentage;
        }
        console.log("Percentage: ", percentage);
    }
    // scale down by 1e4
    function deserved(uint256 _amount) public view returns (uint256 _deserved) {
        uint256 _percentage = percentageDeserved();
        _deserved = (_percentage * _amount) / 1e4;
    }
    function _leaf(string memory payload) internal pure returns (bytes32) {
        return keccak256(abi.encodePacked(payload));
    }
    function _verify(bytes32 leaf, bytes32[] memory proof)
        internal
        view
        returns (bool)
    {
        return MerkleProof.verify(proof, _root, leaf);
    }
    function askForRefund(uint256 _amount, bytes32[] calldata proof) public {
        string memory payload = string(abi.encodePacked(msg.sender, _amount));
        require(
            _verify(_leaf(payload), proof),
            "Invalid Merkle Tree proof supplied."
        );
        refundRequest[msg.sender] = true;
    }
    function emergencyWithdraw() public onlyOwner {
        uint256 _balance = IERC20(_tokenAddress).balanceOf(address(this));
        IERC20(_tokenAddress).transfer(owner(), _balance);
    }
}
