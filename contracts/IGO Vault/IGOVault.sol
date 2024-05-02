// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/utils/ReentrancyGuardUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";
import "@openzeppelin/contracts-upgradeable/utils/PausableUpgradeable.sol";
import "../Interfaces/ISpinStakable.sol";
import "../Interfaces/IIGO.sol";

/// @title Spinstarter Vault
/// @author Spintop.Network
/// @notice Autocompounding Single Vault for IGO staking.
/// @dev Owner operates Vault, IGO, and IGOClaim contracts from this contracts interface.
contract IGOVault is Initializable, ERC20Upgradeable, PausableUpgradeable, OwnableUpgradeable, ReentrancyGuardUpgradeable {
    using EnumerableSet for EnumerableSet.AddressSet;

    struct VaultInfo {
        address pool;
        address tokenSpin;
    }
    VaultInfo public vaultInfo;
    address[] public IGOs;
    uint256 public maxStakeAmount;
    uint256 public minStakeAmount;
    uint256 private pilgrims;
    EnumerableSet.AddressSet private members_;
    uint256 public batchSize;
    EnumerableSet.AddressSet private active_igos_;

    uint256 constant private MAX_INT = 2**256 - 1;

    event Deposit(address indexed account, uint256 amount);
    event Withdraw(address indexed account, uint256 amount);
    event Exit(address indexed account, uint256 amount);

    error AmountIsZero();
    error TransferNotAllowed();
    error ExceedsMaxStakeAmount();
    error ExceedsUserBalance();
    error SpinTransferFailed();

    function initialize(
        string memory _shareName,
        string memory _shareSymbol,
        address _pool,
        address _tokenSpin,
        address initialOwner
    ) initializer public {
        __ERC20_init(_shareName, _shareSymbol);
        __Ownable_init(initialOwner);
        vaultInfo.pool = _pool;
        vaultInfo.tokenSpin = _tokenSpin;
        IERC20(vaultInfo.tokenSpin).approve(vaultInfo.pool, MAX_INT);
        minStakeAmount = 15000e18;
        maxStakeAmount = 5000000e18;
        batchSize = 250;
    }

    // Admin functions //

    function setVaultInfo (address _pool, address _tokenSpin) external onlyOwner {
        vaultInfo.pool = _pool;
        vaultInfo.tokenSpin = _tokenSpin;
        IERC20(vaultInfo.tokenSpin).approve(vaultInfo.pool, MAX_INT);
    }

    function setMinStakeAmount (uint256 _minStakeAmount) external onlyOwner {
        minStakeAmount = _minStakeAmount;
    }

    function setMaxStakeAmount (uint256 _maxStakeAmount) external onlyOwner {
        maxStakeAmount = _maxStakeAmount;
    }

    function createIGO(address _igo) external onlyOwner whenPaused {
        IGOs.push(_igo);
    }

    function migrateBalances () external onlyOwner whenPaused {
        address _igo = IGOs[IGOs.length-1];
        uint256 _pilgrims = pilgrims;
        uint256 queue = members_.length() - _pilgrims;
        bool isQueueSmaller = queue < batchSize;
        uint256 target = isQueueSmaller ? queue : batchSize;
        for (uint i = _pilgrims; i < _pilgrims+target; i++) {
            address member = members_.at(i);
            uint256 balanceOfMember = getUserStaked(member);
            if (balanceOfMember >= minStakeAmount) {
                IIGO(_igo).stake(member, balanceOfMember);
            }
        }
        if (isQueueSmaller) {
            pilgrims = 0;
        } else {
            pilgrims += target;
        }
    }

    function start() external onlyOwner whenPaused {
        address _igo = IGOs[IGOs.length-1];
        IIGO(_igo).start();
        active_igos_.add(_igo);
    }

    function pause() external onlyOwner whenNotPaused {
        _pause();
    }

    function unpause() external onlyOwner whenPaused {
        _unpause();
    }

    function setBatchSize (uint256 _batchSize) external onlyOwner {
        batchSize = _batchSize;
    }

    function setClaimContract(address _claimContract) external onlyOwner {
        address _igo = IGOs[IGOs.length-1];
        IIGO(_igo).setClaimContract(_claimContract);
    }

    function notifyVesting (address _igo, uint256 _percentage) external onlyOwner {
        IIGO(_igo).notifyVesting(_percentage);
    }

    function setToken (address _igo, address _token, uint256 _decimal) external onlyOwner {
        IIGO(_igo).setToken(_token, _decimal);
    }

    function setPeriods (address _igo, uint256 _allocationTime, uint256 _publicTime) external onlyOwner {
        IIGO(_igo).setPeriods(_allocationTime, _publicTime);
    }

    function setMultiplier (address _igo, uint256 _multiplier) external onlyOwner {
        IIGO(_igo).setMultiplier(_multiplier);
    }

    function withdrawIGOFunds (address _igo, uint256 token) external onlyOwner {
        IIGO(_igo).withdrawFunds(token);
    }

    function emergencyWithdraw (address _igo) external onlyOwner {
        IIGO(_igo).emergencyWithdraw();
    }

    function setLinearParams (
        address _igo,
        uint256 startDate,
        uint256 duration,
        uint256 refundPeriodStart,
        uint256 refundPeriodEnd,
        uint256 percentageUnlocked
    ) external onlyOwner {
        IIGO(_igo).setLinearParams(
            startDate,
            duration,
            refundPeriodStart,
            refundPeriodEnd,
            percentageUnlocked
        );
    }

    function setRefundPeriod (address _igo, uint256 refundPeriodStart, uint256 refundPeriodEnd) external onlyOwner {
        IIGO(_igo).setRefundPeriod(refundPeriodStart, refundPeriodEnd);
    }

    // Private functions //

    function addToIGOs (uint256 amount) private {
        address[] memory igosToRemove = new address[](active_igos_.length());

        for (uint256 i; i< active_igos_.length();) {
            IIGO _igo = IIGO(active_igos_.at(i));
            _igo.setStateVault();
            if (_igo.IGOstate()) {
                _igo.stake(_msgSender(),amount);
            } else {
                igosToRemove[i] = active_igos_.at(i);
            }
            unchecked {
                ++i;
            }
        }

        for (uint256 i; i< igosToRemove.length;) {
            if (igosToRemove[i] != address(0)) {
                active_igos_.remove(igosToRemove[i]);
            }
            unchecked {
                ++i;
            }
        }
    }

    function removeFromIGOs (uint256 amount) private {
        address[] memory igosToRemove = new address[](active_igos_.length());
        for (uint256 i; i< active_igos_.length();) {
            IIGO _igo = IIGO(active_igos_.at(i));
            _igo.setStateVault();
            if (_igo.IGOstate()) {
                _igo.unstake(_msgSender(),amount);
            } else {
                igosToRemove[i] = active_igos_.at(i);
            }
            unchecked {
                ++i;
            }
        }

        for (uint256 i; i< igosToRemove.length;) {
            if (igosToRemove[i] != address(0)) {
                active_igos_.remove(igosToRemove[i]);
            }
            unchecked {
                ++i;
            }
        }
    }

    function compound() private {
        uint256 _earned = ISpinStakable(vaultInfo.pool).earned(address(this));
        if (_earned > 0) {
            ISpinStakable(vaultInfo.pool).getReward();
            ISpinStakable(vaultInfo.pool).stake(_earned);
        }
    }

    function _update(
        address from,
        address to,
        uint256 amount
    ) internal virtual override {
        if (!(from == address(0) || to == address(0))) revert TransferNotAllowed();
        super._update(from, to, amount);
    }

    // Public view functions //

    function getUserStaked (address account) public view returns(uint256) {
        if (totalSupply() > 0) {
            return balance() * balanceOf(account) / totalSupply();
        } else {
            return 0;
        }
    }

    function vaultBalance() public view returns (uint) {
        return IERC20(vaultInfo.tokenSpin).balanceOf(address(this));
    }

    function balance() public view returns (uint) {
        return vaultBalance() + ISpinStakable(vaultInfo.pool).balanceOf(address(this));
    }

    function membersLength() public view returns (uint256) {
        return members_.length();
    }

    // Public mutative functions //

    function deposit(uint _amount) external nonReentrant whenNotPaused {
        compound();
        if (_amount == 0) revert AmountIsZero();
        uint256 totalAmount = _amount + getUserStaked(_msgSender());
        if (totalAmount >= maxStakeAmount) revert ExceedsMaxStakeAmount();
        uint256 _bal = balance();
        IERC20(vaultInfo.tokenSpin).transferFrom(_msgSender(), address(this), _amount);
        if (vaultBalance() > 0) {
            ISpinStakable(vaultInfo.pool).stake(vaultBalance());
        }
        uint256 _after = balance();
        _amount = _after - _bal;
        uint256 shares = 0;
        if (totalSupply() == 0) {
            shares = _amount;
        } else {
            shares = _amount * totalSupply() / _bal;
        }
        _mint(_msgSender(), shares);
        if (shares > 0 && totalAmount >= minStakeAmount) {
            addToIGOs(shares);
        }
        members_.add(_msgSender());
        emit Deposit(_msgSender(), _amount);
    }

    function withdraw(uint _amount) external nonReentrant whenNotPaused {
        compound();
        if (_amount == 0) revert AmountIsZero();
        uint256 balanceOfSender = balanceOf(_msgSender()); // vault token shares count of user
        if (balanceOfSender == 0) revert ExceedsUserBalance();
        uint256 requested =  balance() * balanceOfSender / totalSupply(); // total spin balance of user
        if (_amount > requested) revert ExceedsUserBalance();
        uint256 requiredShares = _amount * balanceOfSender / requested; // shares required to withdraw
        if (requiredShares > balanceOfSender) revert ExceedsUserBalance();
        removeFromIGOs(requiredShares);
        _burn(_msgSender(), requiredShares);
        uint vaultAvailable = IERC20(vaultInfo.tokenSpin).balanceOf(address(this));
        if (vaultAvailable < _amount) {
            uint unstakeAmount = _amount - vaultAvailable;
            ISpinStakable(vaultInfo.pool).unstake(unstakeAmount);
            uint vaultAvailableAfter = IERC20(vaultInfo.tokenSpin).balanceOf(address(this));
            uint diff = vaultAvailableAfter - vaultAvailable;
            if (diff < unstakeAmount) {
                _amount = vaultAvailable + diff;
            }
        }
        bool success = IERC20(vaultInfo.tokenSpin).transfer(_msgSender(), _amount);
        if (!success) revert SpinTransferFailed();
        if (balanceOf(_msgSender()) == 0) {
            members_.remove(_msgSender());
        }
        emit Withdraw(_msgSender(), _amount);
    }

    function exit() external nonReentrant whenNotPaused {
        compound();
        uint256 balanceOfSender = balanceOf(_msgSender());
        uint256 requested =  balance() * balanceOfSender / totalSupply();
        if (requested == 0) revert AmountIsZero();
        removeFromIGOs(balanceOfSender);
        _burn(_msgSender(), balanceOfSender);
        uint vaultAvailable = IERC20(vaultInfo.tokenSpin).balanceOf(address(this));
        if (vaultAvailable < requested) {
            uint unstakeAmount = requested - vaultAvailable;
            ISpinStakable(vaultInfo.pool).unstake(unstakeAmount);
            uint vaultAvailableAfter = IERC20(vaultInfo.tokenSpin).balanceOf(address(this));
            uint diff = vaultAvailableAfter - vaultAvailable;
            if (diff < unstakeAmount) {
                requested = vaultAvailable + diff;
            }
        }
        bool success = IERC20(vaultInfo.tokenSpin).transfer(_msgSender(), requested);
        if (!success) revert SpinTransferFailed();
        if (balanceOf(_msgSender()) == 0) {
            members_.remove(_msgSender());
        }
        emit Exit(_msgSender(), requested);
    }
}
