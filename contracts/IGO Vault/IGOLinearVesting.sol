// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.23;

import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";
import "@openzeppelin/contracts/access/Ownable.sol";



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
    uint256 public _refundPeriodStart;
    uint256 public _refundPeriodEnd;
    mapping(address => uint256) public claimedTokens;
    mapping(address => bool) public refundRequest;
    constructor(
        bytes32 root,
        address tokenAddress,
        uint256 tokenAmount,
        uint256 firstClaimTime,
        uint256 duration,
        uint256 percentageUnlocked,
        uint256 refundPeriodStart,
        uint256 refundPeriodEnd,
        address InitialOwner
    )Ownable(InitialOwner){
        require(refundPeriodEnd > refundPeriodStart, "Refund Period must end after it starts.");
        require(percentageUnlocked <= 100, "Percentage Unlocked must be less than 100.");
        _root = root;
        _tokenAddress = tokenAddress;
        _totalAmount = tokenAmount;
        _firstClaimTime = firstClaimTime;
        _duration = duration;
        _percentageUnlocked = percentageUnlocked;
        _refundPeriodStart = refundPeriodStart;
        _refundPeriodEnd = refundPeriodEnd;
    }

    event RefundRequested(address indexed user, uint256 amount);

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
        IERC20(_tokenAddress).transfer(msg.sender, tokensToClaim);
    }

    function isRefundRequested(address _user) public view returns (bool){
        return refundRequest[_user];
    }

    // scale up by 1e4
    function percentageDeserved() public view returns (uint256 percentage) {
        uint256 _now = block.timestamp > _startDate + _duration
            ? _startDate + _duration
            : block.timestamp;
        uint256 timePast = (_now - _startDate) * 1e12;
        uint256 scaledPercentage = (timePast / _duration / 1e10) * (100 - _percentageUnlocked);
        if (_startDate == 0){
            percentage = _percentageUnlocked * 1e2;
        } else {
        percentage = _percentageUnlocked * 1e2 + scaledPercentage;
        }
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
        require(claimedTokens[msg.sender] == 0, "You have already claimed tokens.");
        require(isRefundRequested(msg.sender) == false, "Refund is already requested.");
        string memory payload = string(abi.encodePacked(msg.sender, _amount));
        require(
            _verify(_leaf(payload), proof),
            "Invalid Merkle Tree proof supplied."
        );
        require(_refundPeriodStart< block.timestamp && block.timestamp < _refundPeriodEnd , "Refund Period has ended");
        refundRequest[msg.sender] = true;
        emit RefundRequested(msg.sender, _amount);
    }

    function emergencyWithdraw() public onlyOwner {
        uint256 _balance = IERC20(_tokenAddress).balanceOf(address(this));
        IERC20(_tokenAddress).transfer(owner(), _balance);
    }

    function setParameters(
        bytes32 root,
        address tokenAddress,
        uint256 tokenAmount,
        uint256 firstClaimTime,
        uint256 duration,
        uint256 percentageUnlocked,
        uint256 refundPeriodStart,
        uint256 refundPeriodEnd
    ) public onlyOwner {
        require(refundPeriodEnd > refundPeriodStart, "Refund Period must end after it starts.");
        require(percentageUnlocked <= 100, "Percentage Unlocked must be less than 100.");
        _root = root;
        _tokenAddress = tokenAddress;
        _totalAmount = tokenAmount;
        _duration = duration;
        _percentageUnlocked = percentageUnlocked;
        _firstClaimTime = firstClaimTime;
        _refundPeriodStart = refundPeriodStart;
        _refundPeriodEnd = refundPeriodEnd;
    }
}
