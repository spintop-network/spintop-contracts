// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/utils/Context.sol";
import "../Interfaces/IIGO.sol";

// 'Dollars' symbolize underlying payment tokens. Not necessarily USD.
contract IGOClaim is Context, ReentrancyGuard {
    using SafeERC20 for IERC20;

    uint256 immutable TOTAL_SHARES = 10000;
    address private vault;
    address public paymentToken;
    address public igo;
    address public token;
    uint256 public totalDollars;
    uint256 public price;
    uint256 private decimal;
    bool public state = false;
    mapping(address => uint256) paidAmounts;
    mapping(address => uint256) claimedAmounts;

    constructor (address _vault, address _igo, uint256 _totalDollars, uint256 _price, address _paymentToken) {
        vault = _vault;
        igo = _igo;
        totalDollars = _totalDollars;
        price = _price;
        paymentToken = _paymentToken;
    }
    
    modifier onlyVault {
        require(_msgSender() == vault, "Only Vault.");
        _;
    }

    event ClaimUnlocked(address indexed igo);
    event UserPaid(address indexed user, uint256 amount);
    event UserClaimed(address indexed user, uint256 amount);

    function deservedShare (address _user) internal view returns (uint256 deserved_) {
        uint256 deserved = (IIGO(igo).earned(_user)) / TOTAL_SHARES;
        deserved_ = normalize(deserved);
    }

    function normalize(uint256 _amount) internal view returns (uint256 amount) {
        amount = _amount / 1e18 * 10**decimal;
    }

    function payForTokens (uint256 _amount) public nonReentrant {
        require(_amount > 0, "Can't do zero");
        uint256 deservedDollars = deservedShare(_msgSender()) * totalDollars;
        if(_amount <= (deservedDollars-paidAmounts[_msgSender()])) {
            IERC20(paymentToken).safeTransferFrom(_msgSender(), address(this), deservedDollars);
            paidAmounts[_msgSender()] += _amount;
            emit UserPaid(_msgSender(), _amount);     
        }
    }

    function claimTokens(uint256 _amount) public nonReentrant {
        require(_amount > 0, "Can't do zero");
        require(state == true, "Not yet");
        uint256 deservedDollars = deservedShare(_msgSender()) * totalDollars;
        if (_amount <= (deservedDollars-claimedAmounts[_msgSender()])){
            uint256 deservedTokens = _amount / price;
            IERC20(paymentToken).safeTransfer(_msgSender(), deservedTokens);
            emit UserClaimed(_msgSender(), _amount);
        }
    }

    function unlockTokens (address _token, uint256 _decimal) public onlyVault {
        state = true;
        token = _token;
        decimal = _decimal;
        emit ClaimUnlocked(igo);
    }
}