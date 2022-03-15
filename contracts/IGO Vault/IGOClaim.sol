// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "../Interfaces/IIGO.sol";

contract IGOClaim is Ownable, ReentrancyGuard {
    using SafeERC20 for IERC20;

    uint256 immutable TOTAL_SHARES = 10000;

    address private vault;
    address public paymentToken;
    address public igo;
    address public token;
    uint256 public totalTokenPrice;
    uint256 public price;
    uint256 private decimal;
    bool public state = false;

    constructor (address _vault, address _igo, uint256 _totalTokenPrice, uint256 _price, address _paymentToken) {
        vault = _vault;
        igo = _igo;
        totalTokenPrice = _totalTokenPrice;
        price = _price;
        paymentToken = _paymentToken;
    }

    modifier onlyVault {
        require(_msgSender() == vault, "Only Vault.");
        _;
    }

    function setTokenAddress (address _token, uint256 _decimal) public onlyOwner {
        token = _token;
        decimal = _decimal;
    }
    
    function payForTokens (uint256 _amount) public nonReentrant {
        require(_amount > 0, "Can't do zero");
        require(state == true, "Not yet");
        uint256 deservedDollars = deservedShare(_msgSender()) * totalTokenPrice;
        IERC20(paymentToken).safeTransferFrom(_msgSender(), address(this), deservedDollars);        
    }

    function deservedShare (address _user) internal view returns (uint256 deserved_) {
        uint256 deserved = (IIGO(igo).earned(_user)) / TOTAL_SHARES;
        deserved_ = normalize(deserved);
    }

    function normalize(uint256 _amount) internal view returns (uint256 amount) {
        amount = _amount / 1e18 * 10**decimal;
    }

    function claimTokens () public nonReentrant {
        require(state == true, "Not yet");
        uint256 deservedShare = (IIGO(igo).earned(_msgSender())) / TOTAL_SHARES;
        uint256 deservedTokens = deservedShare * totalTokenPrice / price;
        IERC20(paymentToken).safeTransfer(_msgSender(), deservedTokens);
    }

    function unlockTokens () public onlyVault {
        state = true;
    }
}