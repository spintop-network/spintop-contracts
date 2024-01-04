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
    uint256 constant private MAX_INT = 2**256 - 1;

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
        minStakeAmount = 1000e18;
        maxStakeAmount = 1000000e18;
        batchSize = 500;
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
        uint256 queue = members_.length() - pilgrims;
        uint256 target = queue < batchSize ? queue : batchSize;
        for (uint i = pilgrims; i < pilgrims+target; i++) {
            uint256 balanceOfMember = getUserStaked(members_.at(i));
            if (balanceOfMember >= minStakeAmount) {
                IIGO(_igo).stake(members_.at(i), balanceOfMember);
            }
        }
        pilgrims += target;
        queue < batchSize ? pilgrims = 0 : pilgrims;
    }

    function start() external onlyOwner whenPaused {
        address _igo = IGOs[IGOs.length-1];
        IIGO(_igo).start();
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

    function withdrawIGOFunds (address _igo, uint256 token) external onlyOwner {
        IIGO(_igo).withdrawFunds(token);
    }

    // Private functions //

    function addMember (address _member) private {
        if (!members_.contains(_member)) {
            members_.add(_member);
        }
    }

    function removeMember (address _member) private {
        if (members_.contains(_member)) {
            members_.remove(_member);
        }
    }

    function addToIGOs (uint256 amount) private {
        for (uint256 i; i<IGOs.length; i++) {
            IIGO _igo = IIGO(IGOs[i]);
            _igo.setStateVault();
            if (_igo.IGOstate()) {
                _igo.stake(_msgSender(),amount);
            }
        }
    }

    function removeFromIGOs (uint256 amount) private {
        for (uint256 i; i<IGOs.length; i++) {
            IIGO _igo = IIGO(IGOs[i]);
            _igo.setStateVault();
            if (_igo.IGOstate()) {
                _igo.unstake(_msgSender(),amount);
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
        require(from == address(0) || to == address(0), "Cannot transfer");
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
        _deposit(_amount);
    }

    function _deposit(uint _amount) private {
        uint256 totalAmount = _amount + getUserStaked(_msgSender());
        require(totalAmount < maxStakeAmount);
        compound();
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
        addMember(_msgSender());
    }

    function withdraw(uint restakeAmount) external nonReentrant whenNotPaused {
        _withdraw();
        if (restakeAmount > 0) {
            _deposit(restakeAmount);
        }
    }

    function _withdraw () private {
        compound();
        uint256 balanceOfSender = balanceOf(_msgSender());
        uint256 requested =  balance() * balanceOfSender / totalSupply();
        if (balanceOfSender > 0) {
            removeFromIGOs(balanceOfSender);
            _burn(_msgSender(), balanceOfSender);
        }
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
        IERC20(vaultInfo.tokenSpin).transfer(_msgSender(), requested);
        if (balanceOf(_msgSender()) == 0) {
            removeMember(_msgSender());
        }
    }
}
