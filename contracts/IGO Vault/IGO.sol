// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Context.sol";
import "./IGOClaim.sol";
import "../Libraries/SafeBEP20.sol";
import "../Interfaces/ISpinVault.sol";

contract IGO is Ownable, ReentrancyGuard {
    using SafeBEP20 for IBEP20;
    
    string public gameName;
    address public vault;
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

    uint256 private _totalSupply;
    mapping(address => uint256) private _balances;
    mapping(address => uint256) private _stakingTime;
    uint256 private reward_amount;

    event ClaimContract(
        address vault,
        address igo,
        uint256 totalDollars,
        address paymentToken,
        uint256 price,
        uint256 duration
        );

    constructor(
        string memory _gameName,
        address _vault,
        uint256 _totalDollars,
        address _paymentToken,
        uint256 _price,
        uint256 _duration
    ) {
        gameName = _gameName;
        vault = _vault;
        startDate = block.timestamp;
        totalDollars = _totalDollars;
        rewardsDuration = _duration;
        uint256 _claimDuration = block.timestamp + rewardsDuration;
        claimContract = new IGOClaim(
            vault, 
            address(this),
            _totalDollars,
            _paymentToken,
            _price,
            _claimDuration);
        emit ClaimContract(
            vault,
            address(this),
            _totalDollars,
            _paymentToken,
            _price,
            _claimDuration
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

    modifier onlyVault {
        require(_msgSender() == vault, "Only vault.");
        _;
    }

    event DistributionStart(uint256 reward);
    event RewardPaid(address indexed user, uint256 reward);

    function setPublicMultiplier (uint256 _multiplier) external onlyVault {
        claimContract.setPublicMultiplier(_multiplier);
    }

    function notifyVesting (uint256 _percentage) external onlyVault {
        claimContract.notifyVesting(_percentage);
    }

    function setToken (address _token, uint256 _decimal) external onlyVault {
        claimContract.setToken(_token, _decimal);
    }

    function setPeriods (uint256 _allocationTime, uint256 _publicTime) external onlyVault {
        claimContract.setPeriods(_allocationTime, _publicTime);
    }

    function lastTimeRewardApplicable() public view returns (uint256) {
        return block.timestamp < (startDate + rewardsDuration) ? block.timestamp : (startDate + rewardsDuration);
    }

    function totalStaked() internal view returns (uint256) {
        return _totalSupply;
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
        return rewardPerTokenStored + 
                ((lastTimeRewardApplicable() - lastUpdateTime) * rewardRate * 1e18 / _totalSupply);
    }

    function earned(address account) public view returns (uint256) {
        return (_balances[account] * (rewardPerToken() - (userRewardPerTokenPaid[account])) / 1e18) + rewards[account];
    }

    function start () external onlyVault {
        rewardRate = totalDollars / rewardsDuration;
        emit DistributionStart(totalDollars);
    }

    function setStateVault () external onlyVault returns(bool) {
        IGOstate = block.timestamp < startDate + rewardsDuration;
        return IGOstate;
    }

    function setState () internal {
        IGOstate = block.timestamp < (startDate + rewardsDuration);        
    }

    function stake(address account, uint256 amount) external nonReentrant updateReward(account) {
        require(amount > 0, "Cannot stake 0");
        _totalSupply = _totalSupply + amount;
        _balances[account] = _balances[account] + amount;
    }

    function unstake(address account,uint256 amount) public nonReentrant updateReward(account) {
        require(amount > 0, "Cannot withdraw 0");
        _totalSupply = _totalSupply - amount;
        _balances[account] = _balances[account] - amount;
    }

    function getReward() public nonReentrant updateReward(_msgSender()) {
        uint256 reward = rewards[_msgSender()];
        if (reward > 0) {
            rewards[_msgSender()] = 0;
        }
    }
}