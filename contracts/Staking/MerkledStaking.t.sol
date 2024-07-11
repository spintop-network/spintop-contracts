pragma solidity 0.8.23;

import "forge-std/Test.sol";
import "forge-std/mocks/MockERC20.sol";
import "../../contracts/Staking/MerkledStaking.sol";

contract ContractBTest is Test {

    MockERC20 mockToken;
    MerkledStaking spinStakable;

    address public stakingToken;
    address public rewardToken;
    bytes32 public root = 0xe9398ce6d1fac7d0d11987e4d27ba11e447599fa192963eedbd3637164d5a36a;
    address public owner = address(this);
    address public user1 = address(0x3cff9898Ea68E5E8583F9E1E481Bb8fA74c91705);
    address public user2 = address(0xF6082376fe6a634f892a2fC3f483bca0C4BE20D7);

    bytes32[] user1Proof = [
        bytes32(0x8081e96eba34cda7d3abd17c2799ed0fef748752e6bab16514c98cd41a86b9cd),
        bytes32(0xe152cbbf84728fcfa8c7cd5b092575d701c026d384ffc12368420ba5b3bffa7f),
        bytes32(0xb7caf78ef7e92ab39a5888c4639f6555bcb208c2ab092f5a22c2c740299fbc5a),
        bytes32(0x5238f35d8f4cbad8df51d762ca66df950e82b883f735c158b7dc8225e71e1f31),
        bytes32(0xa1bde086d045967ec6d1fdf466d1a2a509935f1c1a30be586f54d1e8747d52ac),
        bytes32(0xc03e31fa895527333b5a947fe809efcdaf7b7edc148fdaf92093d3a39193ed8a),
        bytes32(0x440e2e0064d9c39c9986e450ee886afdbb88e8c12f051da0f06527bdf8875e4c),
        bytes32(0x3296a3879bda9351bfcf9191c7b3df22e88c7f58e932d91b068fa872c3d6263f)
    ];

    bytes32[] user2Proof = [
        bytes32(0xca1c9e7fc90972bc44ef63349a7e1fc203e9b81c727bd304cc1fe274b9dabbec),
        bytes32(0xb81728d4c5065f9247df00b1d7fbd8ddbd4ca8502f8b0866f87fa94eefd6f0b4),
        bytes32(0x8d3718fafe6b568106e7301520d5a6ecaeac19f8a4a3bb275691942cd6143d4c),
        bytes32(0x5238f35d8f4cbad8df51d762ca66df950e82b883f735c158b7dc8225e71e1f31),
        bytes32(0xa1bde086d045967ec6d1fdf466d1a2a509935f1c1a30be586f54d1e8747d52ac),
        bytes32(0xc03e31fa895527333b5a947fe809efcdaf7b7edc148fdaf92093d3a39193ed8a),
        bytes32(0x440e2e0064d9c39c9986e450ee886afdbb88e8c12f051da0f06527bdf8875e4c),
        bytes32(0x3296a3879bda9351bfcf9191c7b3df22e88c7f58e932d91b068fa872c3d6263f)
    ];


    error InvalidMerkleProof();
    error NotEnoughTokens();
    error ProvidedRewardTooHigh();
    error CannotWithdrawStakingToken();
    error RewardPeriodNotFinished();

    function setUp() public {
        skip(1704935836);

        mockToken = new MockERC20();
        stakingToken = address(mockToken);
        rewardToken = address(mockToken);

        uint256 reward_amount = 10000e18;

        spinStakable = new MerkledStaking(rewardToken, stakingToken, root);

        deal(address(mockToken), address(spinStakable), reward_amount);
        deal(address(mockToken), user1, 1000e18);
        deal(address(mockToken), user2, 1000e18);

        vm.startPrank(user1);
        mockToken.approve(address(spinStakable), type(uint256).max);
        spinStakable.stake(mockToken.balanceOf(user1), user1Proof);
        vm.stopPrank();

        vm.startPrank(user2);
        mockToken.approve(address(spinStakable), type(uint256).max);
        spinStakable.stake(mockToken.balanceOf(user2), user2Proof);
        vm.stopPrank();

        spinStakable.notifyRewardAmount(reward_amount);
    }

    function test_tryCompounding() public {
        for (uint i = 0; i < 30; i++) {
            skip(1 days);
            vm.prank(user1);
            spinStakable.compound(user1Proof);

            vm.startPrank(user2);
            spinStakable.getReward();
            spinStakable.stake(mockToken.balanceOf(user2), user2Proof);
            vm.stopPrank();
        }

        vm.prank(user1);
        spinStakable.exit();

        vm.prank(user2);
        spinStakable.exit();

        assertEq(mockToken.balanceOf(user1), mockToken.balanceOf(user2));
    }

    function test_tryCompound() public {
        for (uint i = 0; i < 30; i++) {
            skip(1 days);
            vm.prank(user1);
            spinStakable.compound(user1Proof);

        }

        vm.prank(user1);
        spinStakable.exit();

    }

    function test_tryGetReward() public {
        for (uint i = 0; i < 30; i++) {
            skip(1 days);

            vm.startPrank(user2);
            spinStakable.getReward();
            spinStakable.stake(mockToken.balanceOf(user2), user2Proof);
            vm.stopPrank();
        }


        vm.prank(user2);
        spinStakable.exit();

    }
}
