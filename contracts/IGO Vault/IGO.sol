// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Context.sol";
import "./IGOClaim.sol";
import "../Interfaces/ISpinVault.sol";

/// @title Spinstarter IGO
/// @author Spintop.Network
/// @notice Standard staking contract without token transfers.
/// @dev IGOClaim contract checks earned amounts for calculations.
contract IGO is Ownable, ReentrancyGuard {
    string public gameName;
    IGOClaim public claimContract;
    bool public IGOstate;
    uint256 public startDate;
    uint256 public rewardRate;
    uint256 public lastUpdateTime;
    uint256 public rewardPerTokenStored;
    uint256 public rewardsDuration;
    uint256 public totalDollars;

    mapping(address => uint256) public userRewardPerTokenPaid;
    mapping(address => uint256) public rewards;

    uint256 public _totalSupply;
    mapping(address => uint256) private _balances;
    mapping(address => uint256) private _stakingTime;
    uint256 private reward_amount;

    event ClaimContract(
        address vault,
        address igo,
        uint256 totalDollars,
        address paymentToken,
        uint256 price,
        uint256 priceDecimal,
        uint256 multiplier
    );

    constructor(
        string memory _gameName,
        uint256 _totalDollars,
        address _paymentToken,
        uint256 _price,
        uint256 _priceDecimal,
        uint256 _duration,
        uint256 _multiplier
    ) {
        gameName = _gameName;
        totalDollars = _totalDollars;
        rewardsDuration = _duration;
        rewardRate = totalDollars / rewardsDuration;
        claimContract = new IGOClaim(
            _msgSender(),
            address(this),
            _totalDollars,
            _paymentToken,
            _price,
            _priceDecimal,
            _multiplier
        );
        claimContract.pause();
        emit ClaimContract(
            _msgSender(),
            address(this),
            _totalDollars,
            _paymentToken,
            _price,
            _priceDecimal,
            _multiplier
        );
    }

    modifier updateReward(address account) {
        rewardPerTokenStored = rewardPerToken();
        lastUpdateTime = lastTimeRewardApplicable();
        if (account != address(0)) {
            rewards[account] = earned(account);
            userRewardPerTokenPaid[account] = rewardPerTokenStored;
        }
        setState();
        _;
    }

    event DistributionStart(uint256 reward);
    event RewardPaid(address indexed user, uint256 reward);

    // Admin functions //a

    function withdrawFunds(uint256 token) external onlyOwner {
        token == 0
            ? claimContract.withdrawDollars()
            : claimContract.withdrawTokens();
    }

    function notifyVesting(uint256 _percentage) external onlyOwner {
        claimContract.notifyVesting(_percentage);
    }

    function setToken(address _token, uint256 _decimal) external onlyOwner {
        claimContract.setToken(_token, _decimal);
    }

    function setPeriods(uint256 _allocationTime, uint256 _publicTime)
        external
        onlyOwner
    {
        claimContract.setPeriods(_allocationTime, _publicTime);
    }

    function start() external onlyOwner updateReward(address(0)) {
        startDate = block.timestamp;
        claimContract.initialize(startDate + rewardsDuration);
        claimContract.unpause();
        emit DistributionStart(totalDollars);
    }

    function setStateVault() external onlyOwner {
        IGOstate = block.timestamp < (startDate + rewardsDuration);
    }

    // Internal functions //

    function totalStaked() private view returns (uint256) {
        return _totalSupply;
    }

    function setState() private {
        IGOstate = block.timestamp < (startDate + rewardsDuration);
    }

    // Public view functions //

    function lastTimeRewardApplicable() public view returns (uint256) {
        return
            block.timestamp < (startDate + rewardsDuration)
                ? block.timestamp
                : (startDate + rewardsDuration);
    }

    function totalRewardAdded() external view returns (uint256) {
        return reward_amount;
    }

    function balanceOf(address account) external view returns (uint256) {
        return _balances[account];
    }

    function rewardPerToken() public view returns (uint256) {
        if (_totalSupply == 0) {
            return rewardPerTokenStored;
        }
        return
            rewardPerTokenStored +
            (((lastTimeRewardApplicable() - lastUpdateTime) *
                rewardRate *
                1e18) / _totalSupply);
    }

    function earned(address account) public view returns (uint256) {
        return
            ((_balances[account] *
                (rewardPerToken() - (userRewardPerTokenPaid[account]))) /
                1e18) + rewards[account];
    }

    // Public mutative functions //

    function stake(address account, uint256 amount)
        external
        updateReward(account)
        onlyOwner
    {
        require(amount > 0, "Cannot stake 0");
        _totalSupply = _totalSupply + amount;
        _balances[account] = _balances[account] + amount;
    }

    function unstake(address account, uint256 amount)
        external
        updateReward(account)
        onlyOwner
    {
        require(amount > 0, "Cannot withdraw 0");
        _balances[account] = _balances[account] - amount;
        _totalSupply = _totalSupply - amount;
    }
}
