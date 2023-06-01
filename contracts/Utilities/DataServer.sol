// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../Interfaces/IPancakePair.sol";
import "../Interfaces/IBEP20.sol";
import "../Interfaces/ISpinStakable.sol";
import "hardhat/console.sol";

uint256 constant SCALE = 10**8;

contract DataServer {
    function getTokenPrice(address token, address lp)
        private
        view
        returns (uint256 price)
    {
        IPancakePair pair = IPancakePair(lp);
        address token_0 = pair.token0();
        address token_1 = pair.token1();
        uint256 decimal_0 = IBEP20(token_0).decimals();
        uint256 decimal_1 = IBEP20(token_1).decimals();
        (uint256 reserve0, uint256 reserve1, ) = pair.getReserves();
        uint256 reserve_0_normalized = reserve0 * 10**decimal_0;
        uint256 reserve_1_normalized = reserve1 * 10**decimal_1;
        if (token_0 == token) {
            price = (reserve_1_normalized * SCALE) / reserve_0_normalized;
        } else {
            price = (reserve_0_normalized * SCALE) / reserve_1_normalized;
        }
    }

    function getPoolTVL(
        address native_token,
        address native_lp,
        address protocol_token,
        address protocol_lp,
        address pool
    ) private view returns (uint256 tvl) {
        console.log("Getting pool tvl...");
        console.log("Scale:", SCALE);
        uint256 native_token_price = getTokenPrice(native_token, native_lp) /
            SCALE;
        uint256 token_price = getTokenPrice(protocol_token, protocol_lp) /
            SCALE;
        uint256 price = native_token_price * token_price;
        uint256 total_staked = ISpinStakable(pool).totalStaked();
        tvl = total_staked * price;
    }

    function getPoolAPY(
        address native_token,
        address native_lp,
        address protocol_token,
        address protocol_lp,
        address pool
    ) private view returns (uint256 apy) {
        uint256 tvl = getPoolTVL(
            native_token,
            native_lp,
            protocol_token,
            protocol_lp,
            pool
        );
        uint256 reward_rate = ISpinStakable(pool).rewardRate();
        apy = (reward_rate * 100 * 365 * 24 * 60 * 60) / (tvl);
    }

    function getFarmTVL(
        address native_token,
        address native_lp,
        address protocol_token,
        address protocol_lp,
        address farm
    ) private view returns (uint256 tvl) {
        console.log("Getting farm tvl...");
        console.log("Scale:", SCALE);
        address farm_lp = ISpinStakable(farm).stakingToken();
        uint256 farm_lp_balance = IBEP20(farm_lp).balanceOf(farm);
        uint256 farm_lp_total_supply = IBEP20(farm_lp).totalSupply();
        uint256 native_token_price = getTokenPrice(native_token, native_lp);
        uint256 token_price_relative = getTokenPrice(
            protocol_token,
            protocol_lp
        );
        uint256 token_price = (native_token_price * token_price_relative) /
            SCALE;
        (uint256 reserve0, uint256 reserve1, ) = IPancakePair(farm_lp)
            .getReserves();
        if (protocol_token == IPancakePair(farm_lp).token0()) {
            tvl =
                (((reserve0 * token_price) / SCALE) * 2 * farm_lp_balance) /
                10**IBEP20(protocol_token).decimals() /
                farm_lp_total_supply;
        } else {
            tvl =
                (((reserve1 * token_price) / SCALE) * 2 * farm_lp_balance) /
                10**IBEP20(protocol_token).decimals() /
                farm_lp_total_supply;
        }
    }

    function getFarmAPY(
        address native_token,
        address native_lp,
        address protocol_token,
        address protocol_lp,
        address farm
    ) private view returns (uint256 apy) {
        uint256 tvl = getFarmTVL(
            native_token,
            native_lp,
            protocol_token,
            protocol_lp,
            farm
        );
        uint256 reward_rate = ISpinStakable(farm).rewardRate();
        uint256 reward_price_relative = getTokenPrice(
            protocol_token,
            protocol_lp
        );
        uint256 native_token_price = getTokenPrice(native_token, native_lp);
        uint256 reward_price = (reward_price_relative * native_token_price) /
            SCALE;
        apy =
            (reward_rate * reward_price * 100 * 365 * 24 * 60 * 60) /
            (tvl * 10**IBEP20(protocol_token).decimals());
    }

    struct Farm {
        uint256 total_staked;
        uint256 tvl;
        uint256 apy;
        uint256 daily_apr;
    }

    function getFarmData(
        address native_token,
        address native_lp,
        address protocol_token,
        address protocol_lp,
        address farm
    ) public view returns (Farm memory data) {
        uint256 tvl = getFarmTVL(
            native_token,
            native_lp,
            protocol_token,
            protocol_lp,
            farm
        );
        uint256 apy = getFarmAPY(
            native_token,
            native_lp,
            protocol_token,
            protocol_lp,
            farm
        );
        data = Farm(ISpinStakable(farm).totalStaked(), tvl, apy, apy / 356);
    }

    function getPoolData(
        address native_token,
        address native_lp,
        address protocol_token,
        address protocol_lp,
        address pool
    ) public view returns (Farm memory data) {
        uint256 tvl = getPoolTVL(
            native_token,
            native_lp,
            protocol_token,
            protocol_lp,
            pool
        );
        uint256 apy = getPoolAPY(
            native_token,
            native_lp,
            protocol_token,
            protocol_lp,
            pool
        );
        data = Farm(ISpinStakable(pool).totalStaked(), tvl, apy, apy / 356);
    }
}
