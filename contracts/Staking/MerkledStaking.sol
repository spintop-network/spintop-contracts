// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";
import "../Libraries/SafeBEP20.sol";

/// @title Spintop Staking Rewards
/// @author Spintop.Network
/// @notice Synthetix inspired single token staking contract.
/// @dev Owner doesn't have control over 'stakingToken', this includes if both staking and reward tokens are the same.
contract MerkledStaking is Ownable, ReentrancyGuard {
    using SafeBEP20 for IBEP20;

    /* ========== STATE VARIABLES ========== */

    bytes32 public _root;

    IBEP20 public rewardsToken;
    IBEP20 public stakingToken;

    uint256 public periodFinish = 0;
    uint256 public rewardRate = 0;
    uint256 public rewardsDuration = 30 days;
    uint256 public lastUpdateTime;
    uint256 public rewardPerTokenStored;

    mapping(address => uint256) public userRewardPerTokenPaid;
    mapping(address => uint256) public rewards;

    uint256 private _totalSupply;
    mapping(address => uint256) private _balances;
    uint256 private reward_amount;

    error InvalidMerkleProof();
    error NotEnoughTokens();
    error ProvidedRewardTooHigh();
    error CannotWithdrawStakingToken();
    error RewardPeriodNotFinished();

    /* ========== CONSTRUCTOR ========== */

    constructor(
        address _rewardsToken,
        address _stakingToken,
        bytes32 _merkleRoot
    ) Ownable(msg.sender) {
        rewardsToken = IBEP20(_rewardsToken);
        stakingToken = IBEP20(_stakingToken);
        _root = _merkleRoot;
    }

    /* ========== VIEWS ========== */

    function totalStaked() external view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) external view returns (uint256) {
        return _balances[account];
    }

    function lastTimeRewardApplicable() public view returns (uint256) {
        return block.timestamp < periodFinish ? block.timestamp : periodFinish;
    }

    function rewardPerToken() public view returns (uint256) {
        if (_totalSupply == 0) {
            return rewardPerTokenStored;
        }
        return rewardPerTokenStored +
            (lastTimeRewardApplicable() - lastUpdateTime) *
            rewardRate *
            1e18 /
            _totalSupply;
    }

    function earned(address account) public view returns (uint256) {
        return _balances[account] * (rewardPerToken() - userRewardPerTokenPaid[account]) / 1e18 + rewards[account];
    }

    function getRewardForDuration() external view returns (uint256) {
        return rewardRate * rewardsDuration;
    }

    function totalRewardAdded() external view returns (uint256) {
        return reward_amount;
    }

    /* ========== MUTATIVE FUNCTIONS ========== */

    function stake(uint256 amount, bytes32[] calldata proof)
        external
        nonReentrant
        updateReward(msg.sender)
        onlyValid(proof)
    {
        if (amount == 0) revert NotEnoughTokens();
        _totalSupply += amount;
        _balances[msg.sender] += amount;
        stakingToken.safeTransferFrom(msg.sender, address(this), amount);
        emit Staked(msg.sender, amount);
    }

    function compound(bytes32[] calldata proof)
    external
    updateReward(msg.sender)
    onlyValid(proof)
    {
        uint256 reward = rewards[msg.sender];
        if (reward == 0) revert NotEnoughTokens();

        rewards[msg.sender] = 0;
        _totalSupply += reward;
        _balances[msg.sender] += reward;

        emit Compound(msg.sender, reward);
    }

    function unstake(uint256 amount)
        public
        nonReentrant
        updateReward(msg.sender)
    {
        if (amount == 0) revert NotEnoughTokens();
        _totalSupply -= amount;
        _balances[msg.sender] -= amount;
        stakingToken.safeTransfer(msg.sender, amount);
        emit Withdrawn(msg.sender, amount);
    }

    function getReward() public nonReentrant updateReward(msg.sender) {
        uint256 reward = rewards[msg.sender];
        if (reward > 0) {
            rewards[msg.sender] = 0;
            rewardsToken.safeTransfer(msg.sender, reward);
            emit RewardPaid(msg.sender, reward);
        }
    }

    function exit() external {
        unstake(_balances[msg.sender]);
        getReward();
    }

    /* ========== RESTRICTED FUNCTIONS ========== */

    // Always needs to update the balance of the contract when calling this method
    function notifyRewardAmount(uint256 reward)
        external
        onlyOwner
        updateReward(address(0))
    {
        if (block.timestamp >= periodFinish) {
            rewardRate = reward / rewardsDuration;
        } else {
            uint256 remaining = periodFinish - block.timestamp;
            uint256 leftover = remaining * rewardRate;
            rewardRate = (reward + leftover) / rewardsDuration;
        }

        // Ensure the provided reward amount is not more than the balance in the contract.
        // This keeps the reward rate in the right range, preventing overflows due to
        // very high values of rewardRate in the earned and rewardsPerToken functions;
        // Reward + leftover must be less than 2^256 / 10^18 to avoid overflow.
        uint256 balance = rewardsToken.balanceOf(address(this));
        if (rewardRate > balance / rewardsDuration) revert ProvidedRewardTooHigh();

        reward_amount += reward;
        lastUpdateTime = block.timestamp;
        periodFinish = block.timestamp + rewardsDuration;
        emit RewardAdded(reward);
    }

    // Added to support recovering LP Rewards from other systems such as BAL to be distributed to holders
    function recoverERC20(address tokenAddress, uint256 tokenAmount)
        external
        onlyOwner
    {
        if (tokenAddress != address(stakingToken)) revert CannotWithdrawStakingToken();

        IBEP20(tokenAddress).safeTransfer(owner(), tokenAmount);
        emit Recovered(tokenAddress, tokenAmount);
    }

    function recoverETH() external onlyOwner {
        if (address(this).balance == 0) revert NotEnoughTokens();

        payable(owner()).transfer(address(this).balance);
    }

    function setRewardsDuration(uint256 _rewardsDuration) external onlyOwner {
        if (block.timestamp <= periodFinish) revert RewardPeriodNotFinished();
        rewardsDuration = _rewardsDuration;
        emit RewardsDurationUpdated(rewardsDuration);
    }

    function setMerkleRoot(bytes32 _merkleRoot) external onlyOwner {
        _root = _merkleRoot;
    }

    /* ========== MODIFIERS ========== */

    modifier updateReward(address account) {
        rewardPerTokenStored = rewardPerToken();
        lastUpdateTime = lastTimeRewardApplicable();
        if (account != address(0)) {
            rewards[account] = earned(account);
            userRewardPerTokenPaid[account] = rewardPerTokenStored;
        }
        _;
    }

    modifier onlyValid(bytes32[] calldata proof) {
        string memory payload = string(abi.encodePacked(msg.sender));
        if (!MerkleProof.verify(proof, _root, keccak256(abi.encodePacked(payload)))) revert InvalidMerkleProof();
        _;
    }

    /* ========== EVENTS ========== */

    event RewardAdded(uint256 reward);
    event Staked(address indexed user, uint256 amount);
    event Compound(address indexed user, uint256 amount);
    event Withdrawn(address indexed user, uint256 amount);
    event RewardPaid(address indexed user, uint256 reward);
    event RewardsDurationUpdated(uint256 newDuration);
    event Recovered(address token, uint256 amount);
}
