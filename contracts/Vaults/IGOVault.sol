// SPDX-License-Identifier: MIT
pragma solidity >0.8.2;

import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "../Interfaces/ISpinStakable.sol";


contract IGOVault is ERC20 {

    using SafeERC20 for IERC20;

    struct VaultInfo {
        string gameName;
        address gameToken;
        address spinToken;
        address LPToken;
        uint256 startDate;
        uint256 endDate;
        uint256 vestingStartDate;
        uint256 vestingEpochs;
        uint256 vestingEpochLength;
        uint256 totalAmount;
    }
    VaultInfo public vaultInfo;


    constructor (
        string memory _gameName, 
        address _gameToken,
        address _spinToken,
        address _LPToken,
        uint256 _startDate,
        uint256 _endDate,
        uint256 _vestingStartDate,
        uint256 _vestingEpochs,
        uint256 _vestingEpochLength,
        uint256 _totalAmount){
            vaultInfo.gameName = _gameName;
            vaultInfo.gameToken = _gameToken;
            vaultInfo.spinToken = _spinToken;
            vaultInfo.LPToken = _LPToken;
            vaultInfo.startDate = _startDate;
            vaultInfo.endDate = _endDate;
            vaultInfo.vestingStartDate = _vestingStartDate;
            vaultInfo.vestingEpochs = _vestingEpochs;
            vaultInfo.vestingEpochLength = _vestingEpochLength;
            vaultInfo.totalAmount = _totalAmount;
        }

    // function calculatePairPrice () private {}

    function balance() public view returns (uint) {
        return IERC20(vaultInfo.spinToken).balanceOf(address(this));
    }

    function earn() public {
        IERC20(vaultInfo.spinToken).safeTransfer(address(this), balance());
        deposit();
    }

    function deposit(uint _amount) public { // add reentrancy
        uint256 _bal = balance();
        if (_bal > 0) {
            ISpinStakable().deposit(_bal);
        }

        // deposit into farm 0
        // add liquidity 
        // deposit into farm all

        uint256 _pool = balance();
        IERC20(vaultInfo.spinToken).safeTransferFrom(msg.sender, address(this), _amount);
        earn();
        uint256 _after = balance();
        _amount = _after.sub(_pool); // Additional check for deflationary tokens
        uint256 shares = 0;
        if (totalSupply() == 0) {
            shares = _amount;
        } else {
            shares = (_amount.mul(totalSupply())).div(_pool);
        }
        _mint(msg.sender, shares);
    }

    function addLiquidity() internal {
        uint256 outputHalf = IERC20(output).balanceOf(address(this)).div(2);

        if (lpToken0 != output) {
            IUniswapRouterETH(unirouter).swapExactTokensForTokens(outputHalf, 0, outputToLp0Route, address(this), block.timestamp);
        }

        if (lpToken1 != output) {
            IUniswapRouterETH(unirouter).swapExactTokensForTokens(outputHalf, 0, outputToLp1Route, address(this), block.timestamp);
        }

        uint256 lp0Bal = IERC20(lpToken0).balanceOf(address(this));
        uint256 lp1Bal = IERC20(lpToken1).balanceOf(address(this));
        IUniswapRouterETH(unirouter).addLiquidity(lpToken0, lpToken1, lp0Bal, lp1Bal, 1, 1, address(this), block.timestamp);
    }
}