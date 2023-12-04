// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Interfaces/IPancakePair.sol";
import "./Interfaces/IBEP20.sol";
import "./Interfaces/ISpinStakable.sol";
import "./Interfaces/IRouter.sol";
import "./Interfaces/IMultiStaking.sol";

uint256 constant SCALE = 10 ** 18;
uint256 constant OUTPUT_SCALE = 10 ** 8;

contract PoolFarmFetcher {
    struct TargetData {
        uint256 total_staked;
        uint256 tvl;
        uint256 apy;
        uint256 daily_apr;
    }

    function getTokenPrice(
        address router,
        uint amountIn,
        address[] memory path
    ) public view returns (uint256[] memory amounts) {
        amounts = IRouter(router).getAmountsOut(amountIn, path);
    }

    function getTotalStaked(address pool) public view returns (uint256) {
        return ISpinStakable(pool).totalStaked();
    }

    function getPoolTVL(
        address[] memory path,
        address protocol_token,
        address stableToken,
        address pool,
        address router,
        uint256 price_coefficient
    ) public view returns (uint256 tvl) {
        uint256 token_price = getTokenPrice(
            router,
            price_coefficient * 10 ** IBEP20(protocol_token).decimals(),
            path
        )[path.length - 1];

        uint256 total_staked = getTotalStaked(pool);
        tvl =
            (total_staked * token_price) /
            (10 ** IBEP20(protocol_token).decimals()) /
            10 ** IBEP20(stableToken).decimals();
    }

    function getPoolAPY(
        address[] memory path,
        address protocol_token,
        address stableToken,
        address pool,
        address router,
        uint256 price_coefficient
    ) public view returns (uint256 apy) {
        uint256 tvl = getPoolTVL(
            path,
            protocol_token,
            stableToken,
            pool,
            router,
            price_coefficient
        );

        uint256 reward_price = getTokenPrice(
            router,
            price_coefficient * 10 ** IBEP20(protocol_token).decimals(),
            path
        )[path.length - 1];
        uint256 reward_rate = ISpinStakable(pool).rewardRate();
        apy =
            (reward_rate *
                reward_price *
                100 *
                365 *
                24 *
                60 *
                60 *
                OUTPUT_SCALE) /
            (tvl * SCALE * 10 ** IBEP20(protocol_token).decimals());
    }

    function getFarmTVL(
        address[] memory path,
        address[] memory path2,
        address farm,
        address router,
        uint256 price_coefficient
    ) public view returns (uint256 tvl) {
        uint256 farm_lp_balance = IBEP20(ISpinStakable(farm).stakingToken())
            .balanceOf(farm);

        uint256 farm_lp_total_supply = IBEP20(
            ISpinStakable(farm).stakingToken()
        ).totalSupply();

        IBEP20 token0_contract = IBEP20(
            IPancakePair(ISpinStakable(farm).stakingToken()).token0()
        );
        IBEP20 token1_contract = IBEP20(
            IPancakePair(ISpinStakable(farm).stakingToken()).token1()
        );

        uint256 token0_price;
        uint256 token1_price;

        token0_price = getTokenPrice(
            router,
            price_coefficient * 10 ** token0_contract.decimals(),
            path
        )[path.length - 1];

        token1_price = getTokenPrice(
            router,
            price_coefficient * 10 ** token1_contract.decimals(),
            path2
        )[path2.length - 1];

        (uint256 reserve0, uint256 reserve1, ) = IPancakePair(
            ISpinStakable(farm).stakingToken()
        ).getReserves();
        uint256 normalized_reserve0 = reserve0 /
            (10 ** token0_contract.decimals());
        uint256 normalized_reserve1 = reserve1 /
            (10 ** token1_contract.decimals());

        tvl =
            ((normalized_reserve0 *
                token0_price +
                normalized_reserve1 *
                token1_price) * farm_lp_balance) /
            farm_lp_total_supply /
            SCALE;
    }

    function getDoubleFarmTVL(
        address[] memory path,
        address[] memory path2,
        address farm,
        address router,
        uint256 price_coefficient
    ) public view returns (uint256) {
        uint256 farm_lp_balance = IBEP20(ISpinStakable(farm).stakingToken())
            .balanceOf(farm);
        uint256 farm_lp_total_supply = IBEP20(
            ISpinStakable(farm).stakingToken()
        ).totalSupply();

        IBEP20 token0_contract = IBEP20(
            IPancakePair(ISpinStakable(farm).stakingToken()).token0()
        );
        IBEP20 token1_contract = IBEP20(
            IPancakePair(ISpinStakable(farm).stakingToken()).token1()
        );

        uint256 token0_price;
        uint256 token1_price;

        token0_price = getTokenPrice(
            router,
            price_coefficient * 10 ** token0_contract.decimals(),
            path
        )[path.length - 1];

        token1_price = getTokenPrice(
            router,
            price_coefficient * 10 ** token1_contract.decimals(),
            path2
        )[path2.length - 1];

        (uint256 reserve0, uint256 reserve1, ) = IPancakePair(
            ISpinStakable(farm).stakingToken()
        ).getReserves();
        uint256 normalized_reserve0 = reserve0 /
            (10 ** token0_contract.decimals());
        uint256 normalized_reserve1 = reserve1 /
            (10 ** token1_contract.decimals());
        return
            ((normalized_reserve0 *
                token0_price +
                normalized_reserve1 *
                token1_price) * farm_lp_balance) /
            farm_lp_total_supply /
            SCALE;
    }

    function getFarmAPY(
        address[] memory path,
        address[] memory path2,
        address reward_token,
        address farm,
        address router,
        uint256 price_coefficient
    ) public view returns (uint256 apy) {
        if (ISpinStakable(farm).periodFinish() < block.timestamp) {
            return 0;
        }

        uint256 tvl = getFarmTVL(path, path2, farm, router, price_coefficient);

        uint256 reward_rate = ISpinStakable(farm).rewardRate();

        uint256 reward_price = getTokenPrice(
            router,
            price_coefficient * 10 ** IBEP20(reward_token).decimals(),
            path
        )[path.length - 1];
        apy =
            (((reward_rate * reward_price * 100 * 365 * 24 * 60 * 60)) *
                OUTPUT_SCALE) /
            (tvl) /
            10 ** IBEP20(reward_token).decimals() /
            SCALE;
    }

    function getDoubleFarmAPY(
        address[] memory path,
        address[] memory path2,
        address farm,
        address router,
        uint256 price_coefficient
    ) public view returns (uint256 apy) {
        if (IMultiStaking(farm).periodFinish() < block.timestamp) {
            return 0;
        }

        uint256 tvl = getDoubleFarmTVL(
            path,
            path2,
            farm,
            router,
            price_coefficient
        );

        address bonus_token = IMultiStaking(farm).bonusToken();
        address reward_token = IMultiStaking(farm).rewardsToken();

        uint256 reward_rate_bonus_token = IMultiStaking(farm).bonusRate();
        uint256 reward_rate_reward_token = IMultiStaking(farm).rewardRate();

        uint256 bonus_token_price = getTokenPrice(
            router,
            price_coefficient * 10 ** IBEP20(bonus_token).decimals(),
            path
        )[path.length - 1];

        uint256 reward_token_price = getTokenPrice(
            router,
            price_coefficient * 10 ** IBEP20(reward_token).decimals(),
            path2
        )[path2.length - 1];

        uint256 apy1 = ((((reward_rate_reward_token * reward_token_price) /
            10 ** IBEP20(reward_token).decimals()) *
            100 *
            365 *
            24 *
            60 *
            60) * OUTPUT_SCALE) /
            (tvl) /
            SCALE;
        uint256 apy2 = ((((bonus_token_price * reward_rate_bonus_token) /
            10 ** IBEP20(bonus_token).decimals()) *
            100 *
            365 *
            24 *
            60 *
            60) * OUTPUT_SCALE) /
            (tvl) /
            SCALE;
        apy = apy1 + apy2;
    }

    function getFarmData(
        address[] memory path,
        address[] memory path2,
        address reward_token,
        address farm,
        address router,
        uint256 price_coefficient
    ) public view returns (TargetData memory data) {
        uint256 tvl = getFarmTVL(path, path2, farm, router, price_coefficient);
        uint256 apy = getFarmAPY(
            path,
            path2,
            reward_token,
            farm,
            router,
            price_coefficient
        );
        data = TargetData(
            ISpinStakable(farm).totalStaked(),
            tvl,
            apy,
            apy / 365
        );
    }

    function getPoolData(
        address[] memory path,
        address protocol_token,
        address pool,
        address stableToken,
        address router,
        uint256 price_coefficient
    ) public view returns (TargetData memory data) {
        uint256 tvl = getPoolTVL(
            path,
            protocol_token,
            stableToken,
            pool,
            router,
            price_coefficient
        );

        uint256 apy = getPoolAPY(
            path,
            protocol_token,
            stableToken,
            pool,
            router,
            price_coefficient
        );
        data = TargetData(
            ISpinStakable(pool).totalStaked(),
            tvl,
            apy,
            apy / 365
        );
    }

    function getDoubleFarmData(
        address[] memory path,
        address[] memory path2,
        address farm,
        address router,
        uint256 price_coefficient
    ) public view returns (TargetData memory data) {
        uint256 tvl = getFarmTVL(path, path2, farm, router, price_coefficient);
        uint256 apy = getDoubleFarmAPY(
            path,
            path2,
            farm,
            router,
            price_coefficient
        );
        data = TargetData(
            IMultiStaking(farm).totalStaked(),
            tvl,
            apy,
            apy / 365
        );
    }
}
