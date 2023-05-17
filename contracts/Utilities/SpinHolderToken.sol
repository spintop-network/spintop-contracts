// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "../Interfaces/ISpinStakable.sol";
import "../Interfaces/ISpinVault.sol";
import "../Interfaces/IPancakePair.sol";

/// @title Spintop Holder Token
/// @author @takez0_o
/// @notice Consolidates all Spintop balances into one token.
/// @dev Ephemeral contract used only for holder balance consolidation.

contract SpinHolderToken is ERC20 {
    address public spin;
    address public pool;
    address public farm;
    address public vault;
    address public LP;

    constructor(
        address _spin,
        address _pool,
        address _farm,
        address _vault
    ) ERC20("SpinHolderToken", "SHT") {
        spin = _spin;
        pool = _pool;
        farm = _farm;
        vault = _vault;
        LP = ISpinStakable(farm).stakingToken();
    }

    function balanceOf(address account) public view override returns (uint256) {
        uint256 farm_balance = getFarmBalance(account);
        uint256 pool_balance = ISpinStakable(pool).balanceOf(account);
        uint256 spin_balance = IERC20(spin).balanceOf(account);
        uint256 vault_balance = ISpinVault(vault).getUserStaked(account);
        return farm_balance + pool_balance + spin_balance + vault_balance;
    }

    function getFarmBalance(address account) internal view returns (uint256) {
        (uint112 reserve0, uint112 reserve1, uint32 timestamp) = IPancakePair(
            LP
        ).getReserves();
        uint256 lp_balance = ISpinStakable(farm).balanceOf(account);
        uint256 total_lp_supply = IPancakePair(LP).totalSupply();
        uint256 total_spin = (reserve0 * lp_balance) / total_lp_supply;
        return total_spin;
    }
}
