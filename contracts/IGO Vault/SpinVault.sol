// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "../Interfaces/ISpinStakable.sol";
import "./IGO.sol";
import "./ClaimToken.sol";
import "hardhat/console.sol";


contract SpinVault is ERC20 {
    using SafeERC20 for IERC20;

    struct VaultInfo {
        address admin;
        string shareName;
        string shareSymbol;
        address pool;
        address tokenSpin;
    }
    VaultInfo public vaultInfo;
    address[] public IGOs;
    address[] public members;
    uint256 immutable public maxStakeAmount = 1000000;
    uint256 immutable public minStakeAmount = 1000;
    uint256 constant private MAX_INT = 2**256 - 1;

    constructor ( 
        string memory _shareName,
        string memory _shareSymbol,
        address _pool,
        address _tokenSpin
        ) ERC20(_shareName,_shareSymbol) {
            vaultInfo.admin = _msgSender();
            vaultInfo.shareName = _shareName;
            vaultInfo.shareSymbol = _shareSymbol;
            vaultInfo.pool = _pool;
            vaultInfo.tokenSpin = _tokenSpin;
            IERC20(vaultInfo.tokenSpin).approve(vaultInfo.pool, MAX_INT);
    }
    
    modifier onlyAdmin () {
        require(_msgSender() == vaultInfo.admin, "Only admin!");
        _;
    }

    function createIGO (
        string memory _gameName,
        string memory _gameSymbol,
        uint256 _startDate) public onlyAdmin {
        ClaimToken _igoToken = new ClaimToken(_gameName, _gameSymbol);
        IGO _igo = new IGO(
            _gameName, 
            address(_igoToken), 
            address(this), 
            _startDate);
        IGOs.push(address(_igo));
        _igoToken.transfer(address(_igo),10e24);
    }

    function getIGO (uint256 _id) public view returns(address) {
        return IGOs[_id];
    }

    function updateIGOs () public {
        for (uint256 i; i<IGOs.length; i++) {
            if (IGO(IGOs[i]).checkState()) {
                IGO(IGOs[i]).updateWithVault(_msgSender());
                console.log("updateIGOs",i);
            }
        }
    }

    function timeStamp () public view returns (uint) {
        return block.timestamp;
    }

    function vaultBalance () public view returns (uint) {
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

    function deposit(uint _amount) external { // add reentrancy
        compound();
        uint256 _bal = balance();
        IERC20(vaultInfo.tokenSpin).safeTransferFrom(msg.sender, address(this), _amount);
        if (vaultBalance() > 0) {
            ISpinStakable(vaultInfo.pool).stake(vaultBalance());
        }
        uint256 _after = balance();
        _amount = _after - _bal; // Additional check for deflationary tokens
        uint256 shares = 0;
        if (totalSupply() == 0) {
            shares = _amount;
        } else {
            shares = _amount * totalSupply() / _bal;
        }
        _mint(msg.sender, shares);
        updateIGOs();
    }

    function withdraw (uint _shares) external {
        compound();
        updateIGOs();
        uint256 r = balance() * _shares / totalSupply();
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
    }
}