// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "../Interfaces/ISpinStakable.sol";
import "../Interfaces/IIGOClaim.sol";
import "./IGO.sol";
import "./IGOClaim.sol";

contract IGOVault is ERC20, Ownable, ReentrancyGuard {
    using SafeERC20 for IERC20;

    struct VaultInfo {
        address admin;
        address pool;
        address tokenSpin;
    }
    VaultInfo public vaultInfo;
    address[] public IGOs;
    address[] public members;
    uint256 immutable public maxStakeAmount = 1000000e18;
    uint256 immutable public minStakeAmount = 1000e18;
    uint256 constant private MAX_INT = 2**256 - 1;

    event IGOContract(
        string gameName,
        address vault,
        uint256 totalDollars,
        address paymentToken,
        uint256 price,
        uint256 duration);

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

    function createIGO (
        string memory _gameName,
        uint256 _totalDollars,
        address _paymentToken,
        uint256 _price,
        uint256 _duration) public onlyOwner {
        IGO _igo = new IGO(
            _gameName, 
            address(this), 
            _totalDollars,
            _paymentToken,
            _price,
            _duration);
        IGOs.push(address(_igo));
        migrateBalances(address(_igo));
        IGO(_igo).start();
        emit IGOContract(
            _gameName,
            address(this),
            _totalDollars,
            _paymentToken,
            _price,
            _duration
        );
    }

    function notifyVesting (address _igo, uint256 _percentage) external onlyOwner {
        IGO(_igo).notifyVesting(_percentage);
    }

    function setPublicMultiplier (address _igo, uint256 _multiplier) external onlyOwner {
        IGO(_igo).setPublicMultiplier(_multiplier);
    }

    function setToken (address _igo, address _token, uint256 _decimal) external onlyOwner {
        IGO(_igo).setToken(_token, _decimal);
    }

    function setPeriods (address _igo, uint256 _allocationTime, uint256 _publicTime) external onlyOwner {
        IGO(_igo).setPeriods(_allocationTime, _publicTime);
    }

    function migrateBalances (address _igo) internal {
        for (uint i; i < members.length; i++) {
            IGO(_igo).stake(members[i], balanceOf(members[i]));
        }
    }

    function getIGO (uint256 _id) public view returns(address) {
        return IGOs[_id];
    }

    function addToIGOs (uint256 amount) internal {
        for (uint256 i; i<IGOs.length; i++) {
            IGO(IGO(IGOs[i])).setStateVault();
            if (IGO(IGOs[i]).IGOstate()) {
                IGO(IGOs[i]).stake(_msgSender(),amount);
            }
        }
    }

    function removeFromIGOs (uint256 amount) internal {
        for (uint256 i; i<IGOs.length; i++) {
            IGO(IGO(IGOs[i])).setStateVault();
            if (IGO(IGOs[i]).IGOstate()) {
                IGO(IGOs[i]).unstake(_msgSender(),amount);
            }
        }
    }

    function getUserStaked (address account) external view returns(uint256) {
        return balance() * balanceOf(account) / totalSupply();
    }

    function vaultBalance() public view returns (uint) {
        uint256 _vaultBalance = IERC20(vaultInfo.tokenSpin).balanceOf(address(this));
        return _vaultBalance;
    }

    function balance() public view returns (uint) {
        uint256 _vaultBalance = vaultBalance();
        uint256 _poolBalance = ISpinStakable(vaultInfo.pool).balanceOf(address(this));
        return _vaultBalance + _poolBalance;
    }
    
    function compound() internal {
        uint256 _earned = ISpinStakable(vaultInfo.pool).earned(address(this));
        if (_earned > 0) {
            ISpinStakable(vaultInfo.pool).getReward();
            ISpinStakable(vaultInfo.pool).stake(_earned);
        }
    }

    function deposit(uint _amount) external nonReentrant {
        require(_amount >= minStakeAmount, "Minimum of 1000 SPIN can be staked.");
        addToIGOs(_amount);
        compound();
        uint256 _bal = balance();
        IERC20(vaultInfo.tokenSpin).safeTransferFrom(msg.sender, address(this), _amount);
        if (vaultBalance() > 0) {
            ISpinStakable(vaultInfo.pool).stake(vaultBalance());
        }
        uint256 _after = balance();
        // Additional check for deflationary tokens
        _amount = _after - _bal;
        uint256 shares = 0;
        if (totalSupply() == 0) {
            shares = _amount;
        } else {
            shares = _amount * totalSupply() / _bal;
        }
        _mint(msg.sender, shares);
        members.push(_msgSender());
    }

    function withdraw (uint _shares) external {
        uint256 r = balance() * _shares / totalSupply();
        removeFromIGOs(r);
        compound();
        _burn(msg.sender, _shares);
        uint b = IERC20(vaultInfo.tokenSpin).balanceOf(address(this));
        if (b < r) {
            uint _withdraw = r - b;
            ISpinStakable(vaultInfo.pool).unstake(_withdraw);
            uint a = IERC20(vaultInfo.tokenSpin).balanceOf(address(this));
            uint d = a - b;
            if (d < _withdraw) {
                r = b + d;
            }
        }
        IERC20(vaultInfo.tokenSpin).safeTransfer(msg.sender, r);
        // delete by popping for longterm optimization
        if (balanceOf(_msgSender()) == 0) {
            for (uint i; i < members.length; i++) {
                if (members[i] == _msgSender()) {
                    members[i] = members[members.length - 1];
                    members.pop();
                }
            }
        }
    }
}