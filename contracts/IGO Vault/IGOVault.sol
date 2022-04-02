// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "../Interfaces/ISpinStakable.sol";
import "./IGO.sol";

/// @title Spinstarter Vault
/// @author Spintop.Network
/// @notice Autocompounding Single Vault for IGO staking.
/// @dev Owner operates Vault, IGO, and IGOClaim contracts from this contracts interface.
contract IGOVault is ERC20, Pausable, Ownable, ReentrancyGuard {
    using EnumerableSet for EnumerableSet.AddressSet;

    struct VaultInfo {
        address admin;
        address pool;
        address tokenSpin;
    }
    VaultInfo public vaultInfo;
    
    address[] public IGOs;
    uint256 immutable public maxStakeAmount = 1000000e18;
    uint256 immutable public minStakeAmount = 1000e18;

    uint256 private pilgrims;
    EnumerableSet.AddressSet private members_;
    uint256 private batchSize = 500;
    uint256 constant private MAX_INT = 2**256 - 1;

    constructor ( 
        string memory _shareName,
        string memory _shareSymbol,
        address _pool,
        address _tokenSpin
        ) ERC20(_shareName,_shareSymbol) {
            vaultInfo.admin = _msgSender();
            vaultInfo.pool = _pool;
            vaultInfo.tokenSpin = _tokenSpin;
            IERC20(vaultInfo.tokenSpin).approve(vaultInfo.pool, MAX_INT);
    }

    // Admin functions //

    function createIGO (
        string memory _gameName,
        uint256 _totalDollars,
        address _paymentToken,
        uint256 _price,
        uint256 _priceDecimal,
        uint256 _duration,
        uint256 _multiplier) external onlyOwner whenPaused {
        IGO _igo = new IGO(
            _gameName, 
            _totalDollars,
            _paymentToken,
            _price,
            _priceDecimal,
            _duration,
            _multiplier);
        IGOs.push(address(_igo));
    }

    function migrateBalances () external onlyOwner whenPaused {
        address _igo = IGOs[IGOs.length-1];
        uint256 queue = members_.length() - pilgrims;
        uint256 target = queue < batchSize ? queue : batchSize;
        for (uint i = pilgrims; i < pilgrims+target; i++) {
            IGO(_igo).stake(members_.at(i), balanceOf(members_.at(i)));
        }
        pilgrims += target;
        queue < batchSize ? pilgrims = 0 : pilgrims;
    }

    function start() external onlyOwner {
        address _igo = IGOs[IGOs.length-1];
        IGO(_igo).start();
    }

    function pause() external onlyOwner {
        _pause();
    }

    function unpause() external onlyOwner {
        _unpause();
    }

    function notifyVesting (address _igo, uint256 _percentage) external onlyOwner {
        IGO(_igo).notifyVesting(_percentage);
    }

    function setToken (address _igo, address _token, uint256 _decimal) external onlyOwner {
        IGO(_igo).setToken(_token, _decimal);
    }

    function setPeriods (address _igo, uint256 _allocationTime, uint256 _publicTime) external onlyOwner {
        IGO(_igo).setPeriods(_allocationTime, _publicTime);
    }

    function withdrawIGOFunds (address _igo) external onlyOwner {
        IGO(_igo).withdrawFunds();
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
            IGO(IGOs[i]).setStateVault();
            if (IGO(IGOs[i]).IGOstate()) {
                IGO(IGOs[i]).stake(_msgSender(),amount);
            }
        }
    }

    function removeFromIGOs (uint256 amount) private {
        for (uint256 i; i<IGOs.length; i++) {
            IGO(IGOs[i]).setStateVault();
            if (IGO(IGOs[i]).IGOstate()) {
                IGO(IGOs[i]).unstake(_msgSender(),amount);
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

    function _beforeTokenTransfer(address from, address to, uint256 amount)
        internal
        whenNotPaused
        override
    {
        super._beforeTokenTransfer(from, to, amount);
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
        require(_amount >= minStakeAmount);
        require((_amount + getUserStaked(_msgSender())) < maxStakeAmount);
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
        addToIGOs(shares);
        if (!members_.contains(_msgSender())){
            addMember(_msgSender());
        }
    }

    function withdraw () external whenNotPaused {
        compound();
        uint256 requested =  balance() * balanceOf(_msgSender()) / totalSupply();
        removeFromIGOs(balanceOf(_msgSender()));
        _burn(_msgSender(), balanceOf(_msgSender()));
        uint vaultAvailable = IERC20(vaultInfo.tokenSpin).balanceOf(address(this));
        if (vaultAvailable < requested) {
            uint _withdraw = requested - vaultAvailable;
            ISpinStakable(vaultInfo.pool).unstake(_withdraw);
            uint vaultAvailableAfter = IERC20(vaultInfo.tokenSpin).balanceOf(address(this));
            uint diff = vaultAvailableAfter - vaultAvailable;
            if (diff < _withdraw) {
                requested = vaultAvailable + diff;
            }
        }
        IERC20(vaultInfo.tokenSpin).transfer(_msgSender(), requested);
        if (balanceOf(_msgSender()) == 0) {
            removeMember(_msgSender());
        }
    }
}