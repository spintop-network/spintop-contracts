// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "../Interfaces/ISpinStakable.sol";
import "./IGOStakable.sol";
import "./ClaimToken.sol";


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

    mapping(address => uint256) balances;

    constructor ( 
        string memory _shareName,
        string memory _shareSymbol,
        address _pool,
        address _tokenSpin,
        ) ERC20(_shareName,_shareSymbol) {
            vaultInfo.admin = _msgSender();
            vaultInfo.shareName = _shareName;
            vaultInfo.shareSymbol = _shareSymbol;
            vaultInfo.pool = _pool;
            vaultInfo.tokenSpin = _tokenSpin;
    }
    
    modifier onlyAdmin () {
        require(_msgSender() == vaultInfo.admin, "Only admin!");
        _;
    }

    function vaultBalanceOf(address _account) public returns(uint256) {
        return balances[_account];
    }

    function createIGO (
        string memory _gameName,
        string memory _gameSymbol,
        address _tokenGame,
        uint256 _startDate,
        uint256 _length ) public onlyAdmin returns(address addr) {
        IGOStakable _igo = new IGOStakable(_gameName, _gameSymbol, vaultInfo.tokenSpin,vaultInfo.tokenSpin, address(this));
        bytes memory _code = type(_igo).creationCode;
        assembly { addr := create(0, add(_code, 0x20), mload(_code)) }
        require(addr != address(0), "deploy failed");
        IGOs[].push(addr);
        ClaimToken _igoToken = new ClaimToken(_gameName, _gameSymbol);
        _igoToken.safeTransfer(addr,10**24);    
    }

    function getIGO (uint256 _id) public view returns(address) {
        return IGOs[_id];
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
        IGOStakable(vaultInfo.pool).update(_msgSender());

        uint256 _bal = balance();
        if (_bal > 0) {
            ISpinStakable(vaultInfo.pool).stake(_bal);
        }
        IERC20(vaultInfo.spinToken).safeTransferFrom(msg.sender, address(this), _amount);
        IERC20(vaultInfo.spinToken).safeTransfer(address(this), balance());
        uint256 _after = balance();
        _amount = _after - _bal; // Additional check for deflationary tokens
        uint256 shares = 0;
        if (totalSupply() == 0) {
            shares = _amount;
        } else {
            shares = _amount * totalSupply() / _bal;
        }
        _mint(msg.sender, shares);
    }

    function withdraw (uint _shares) external {
        compound();
        IGOStakable(vaultInfo.pool).update(_msgSender());

        uint256 r = (balance().mul(_shares)).div(totalSupply());
        _burn(msg.sender, _shares);

        uint b = IERC20(vaultInfo.spinToken).balanceOf(address(this));
        if (b < r) {
            uint _withdraw = r - b;
            ISpinStakable(vaultInfo.pool).withdraw(_withdraw);
            uint a = IERC20(vaultInfo.spinToken).balanceOf(address(this));
            uint d = a - b;
            if (d < _withdraw) {
                r = b + d;
            }
        }
        IERC20(vaultInfo.spinToken).safeTransfer(msg.sender, r);
    }
}