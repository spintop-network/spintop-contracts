pragma solidity 0.8.23;

import "forge-std/Test.sol";
import "forge-std/mocks/MockERC20.sol";
import "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";
import "@openzeppelin/contracts/proxy/transparent/ProxyAdmin.sol";
import "../../contracts/IGO Vault/IGOVault.sol";
import "../../contracts/IGO Vault/IGO.sol";
import "../../contracts/IGO Vault/IGOClaim.sol";
import "../../contracts/Staking/SpinStakable.sol";

contract ContractBTest is Test {
    IGOVault igoVaultImplementation;
    TransparentUpgradeableProxy igoVaultProxy;
    IGOVault igoVault;
    ProxyAdmin admin;

    IGO igoImplementation;
    TransparentUpgradeableProxy igoProxy;
    IGO igo;
    ProxyAdmin igoAdmin;

    IGOClaim igoClaimImplementation;
    TransparentUpgradeableProxy igoClaimProxy;
    IGOClaim igoClaim;
    ProxyAdmin igoClaimAdmin;

    MockERC20 mockToken;
    SpinStakable spinStakable;

    uint public rewardsDuration = 86400;
    uint public allocationPeriod = 86400;
    uint public publicPeriod = 86400;
    uint public totalDollars = 10000e18;
    address public paymentToken;
    address public gameToken;
    uint public gameTokenDecimal = 18;
    uint public price = 10;
    uint public priceDecimals = 3;
    uint public multiplier = 2;
    bool public isLinear = true;
    address public owner = address(this);

    error TransferNotAllowed();
    error ExceedsMaxStakeAmount();
    error AllocationNotStarted();
    error AllocationEnded();
    error PublicSaleNotStarted();
    error PublicSaleEnded();
    error IGONotEnded();
    error LinearVestingDisabled();
    error LinearVestingNotStarted();
    error AmountIsZero();
    error AmountIsTooHigh();
    error AmountIsMoreThanMaxPublicBuy();
    error AlreadyClaimed();
    error AlreadyRefunded();
    error RefundPeriodNotStarted();
    error RefundPeriodEnded();
    error AllTokensClaimed();
    error NotEnoughTokens();
    error TransferFailed();

    function setUp() public {
        skip(1704935836);

        // Deploy ERC20 mock token
        mockToken = new MockERC20();
        paymentToken = address(mockToken);
        gameToken = address(mockToken);

        // Deploy the SpinStakable contract
        spinStakable = new SpinStakable(address(mockToken), address(mockToken));

        // Deploy the IGOVault contract
        admin = new ProxyAdmin(owner);
        igoVaultImplementation = new IGOVault();
        igoVaultProxy = new TransparentUpgradeableProxy(address(igoVaultImplementation), address(admin), "");
        igoVault = IGOVault(address(igoVaultProxy));

        igoVault.initialize(
            "Spinstarter Vault",
            "SPIN",
            address(spinStakable),
            address(mockToken),
            owner
        );

        // Deposit amounts for testing migrate balances function

        address[] memory users = new address[](4);
        users[0] = makeAddr("enes");
        users[1] = makeAddr("enes2");
        users[2] = makeAddr("enes3");
        users[3] = makeAddr("enes4");

        address nonIGOUser = makeAddr("enes5");
        deal(address(mockToken), nonIGOUser, igoVault.minStakeAmount() - 1);
        vm.startPrank(nonIGOUser);
        mockToken.approve(address(igoVault), mockToken.balanceOf(nonIGOUser));
        igoVault.deposit(mockToken.balanceOf(nonIGOUser));
        vm.stopPrank();

        for (uint i = 0; i < users.length; i++) {
            deal(address(mockToken), users[i], igoVault.minStakeAmount() * 2);
            vm.startPrank(users[i]);
            mockToken.approve(address(igoVault), mockToken.balanceOf(users[i]));
            igoVault.deposit(mockToken.balanceOf(users[i]));
            vm.stopPrank();
        }


        // Pause the vault
        igoVault.pause();

        // Create an igo contract
        igoAdmin = new ProxyAdmin(address(igoVaultProxy));
        igoImplementation = new IGO();
        igoProxy = new TransparentUpgradeableProxy(address(igoImplementation), address(igoAdmin), "");
        igo = IGO(address(igoProxy));

        igo.initialize(
            "Spinstarter IGO",
            totalDollars,
            rewardsDuration,
            address(igoVaultProxy)
        );

        igoVault.createIGO(address(igoProxy));

        // Create an igoClaim contract
        igoClaimAdmin = new ProxyAdmin(address(igoProxy));
        igoClaimImplementation = new IGOClaim();
        igoClaimProxy = new TransparentUpgradeableProxy(address(igoClaimImplementation), address(igoClaimAdmin), "");
        igoClaim = IGOClaim(address(igoClaimProxy));

        igoClaim.initialize(
            address(igoVaultProxy),
            address(igoProxy),
            totalDollars,
            paymentToken,
            price,
            priceDecimals,
            multiplier,
            isLinear,
            address(igoProxy)
        );

        igoVault.setClaimContract(address(igoClaimProxy));

        // No need to call migrateBalances more than once, because it is a test environment and there are no 200+ users
        igoVault.setBatchSize(200);
        igoVault.start();
        igoVault.migrateBalances();
        igoVault.unpause();

        igoVault.setPeriods(address(igo), allocationPeriod, publicPeriod);
        igoVault.setToken(address(igo), gameToken, gameTokenDecimal);
    }

    // Prevent igo shares token transfers
    function test_transferIGOVaultBalance() public {
        uint minStakeAmount = igoVault.minStakeAmount();
        deal(address(mockToken), address(this), minStakeAmount);
        mockToken.approve(address(igoVault), minStakeAmount);
        igoVault.deposit(minStakeAmount);

        address user = makeAddr("user");
        uint balance = igoVault.balanceOf(address(this));
        assert(balance > 0);

        vm.expectRevert(TransferNotAllowed.selector);
        igoVault.transfer(user, balance);
    }

    function test_tryPayBeforeAllocation() public {
        uint balance = igoVault.minStakeAmount() * 2;
        deal(address(mockToken), address(this), balance);
        mockToken.approve(address(igoVault), balance);

        vm.expectRevert(AllocationNotStarted.selector);
        igoClaim.payForTokens(balance);
    }

    function test_tryPayWithZeroAmount() public {
        skip(rewardsDuration + 1);

        vm.expectRevert(AmountIsZero.selector);
        igoClaim.payForTokens(0);
    }

    function test_tryPayWithNoAllocation() public {
        uint balance = igoVault.minStakeAmount() * 2;
        deal(address(mockToken), address(this), balance);
        mockToken.approve(address(igoVault), balance);

        skip(rewardsDuration + 1);

        vm.expectRevert(AmountIsTooHigh.selector);
        igoClaim.payForTokens(balance);
    }

    function test_payWithAllocation() public {
        uint balance = igoVault.minStakeAmount() * 3;
        deal(address(mockToken), address(this), balance);
        mockToken.approve(address(igoVault), balance);

        igoVault.deposit(igoVault.minStakeAmount());

        skip(rewardsDuration + 1);

        uint deserved = igoClaim.deservedAllocation(address(this));
        mockToken.approve(address(igoClaim), balance);
        igoClaim.payForTokens(deserved);
    }

    function test_tryPayMoreThanDeserved() public {
        uint balance = totalDollars + igoVault.minStakeAmount();
        deal(address(mockToken), address(this), balance);
        mockToken.approve(address(igoVault), balance);

        igoVault.deposit(igoVault.minStakeAmount());

        skip(rewardsDuration + 1);
        uint deserved = igoClaim.deservedAllocation(address(this));
        mockToken.approve(address(igoClaim), balance);

        vm.expectRevert(AmountIsTooHigh.selector);
        igoClaim.payForTokens(deserved + 1);
    }

    function test_tryClaimBeforeLinearVestingStarts() public {
        uint balance = totalDollars + igoVault.minStakeAmount();
        deal(address(mockToken), address(this), balance);
        mockToken.approve(address(igoVault), balance);

        igoVault.deposit(igoVault.minStakeAmount());

        skip(rewardsDuration + 1);
        uint deserved = igoClaim.deservedAllocation(address(this));
        mockToken.approve(address(igoClaim), balance);

        igoClaim.payForTokens(deserved);

        skip(allocationPeriod + publicPeriod);

        vm.expectRevert(LinearVestingNotStarted.selector);
        igoClaim.claimTokens();
    }

    function test_tryRefundBeforeRefundPeriod() public {
        vm.expectRevert(RefundPeriodNotStarted.selector);
        igoClaim.askForRefund();
    }

    function test_tryRefundAfterClaim() public {
        uint balance = totalDollars + igoVault.minStakeAmount();
        deal(address(mockToken), address(this), balance);
        mockToken.approve(address(igoVault), balance);

        igoVault.deposit(igoVault.minStakeAmount());

        skip(rewardsDuration + 1);
        uint deserved = igoClaim.deservedAllocation(address(this));
        mockToken.approve(address(igoClaim), balance);

        igoClaim.payForTokens(deserved);

        skip(allocationPeriod + publicPeriod);

        igoVault.setLinearParams(
            address(igo),
            block.timestamp,
            86400,
            block.timestamp,
            block.timestamp + 43200,
            25
        );
        deal(address(mockToken), address(this), balance + igoClaim.deservedByUser(address(this)));

        mockToken.transfer(address(igoClaim), igoClaim.deservedByUser(address(this)));
        deal(address(mockToken), address(this), 0);

        igoClaim.claimTokens();
        vm.expectRevert(AlreadyClaimed.selector);
        igoClaim.askForRefund();
    }

    function test_tryClaimAfterRefund() public {
        uint balance = totalDollars + igoVault.minStakeAmount();
        deal(address(mockToken), address(this), balance);
        mockToken.approve(address(igoVault), balance);

        igoVault.deposit(igoVault.minStakeAmount());

        skip(rewardsDuration + 1);
        uint deserved = igoClaim.deservedAllocation(address(this));
        mockToken.approve(address(igoClaim), balance);

        igoClaim.payForTokens(deserved);

        skip(allocationPeriod + publicPeriod);

        igoVault.setLinearParams(
            address(igo),
            block.timestamp,
            86400,
            block.timestamp,
            block.timestamp + 43200,
            25
        );
        skip(1);
        deal(address(mockToken), address(this), balance + igoClaim.deservedByUser(address(this)));

        mockToken.transfer(address(igoClaim), igoClaim.deservedByUser(address(this)));
        deal(address(mockToken), address(this), 0);

        igoClaim.askForRefund();

        vm.expectRevert(AlreadyRefunded.selector);
        igoClaim.claimTokens();
    }

    function test_tryRefundAfterRefundEnds() public {
        uint balance = totalDollars + igoVault.minStakeAmount();
        deal(address(mockToken), address(this), balance);
        mockToken.approve(address(igoVault), balance);

        igoVault.deposit(igoVault.minStakeAmount());

        skip(rewardsDuration + 1);
        uint deserved = igoClaim.deservedAllocation(address(this));
        mockToken.approve(address(igoClaim), balance);

        igoClaim.payForTokens(deserved);

        skip(allocationPeriod + publicPeriod);

        igoVault.setLinearParams(
            address(igo),
            block.timestamp,
            86400,
            block.timestamp,
            block.timestamp + 43200,
            25
        );
        deal(address(mockToken), address(this), balance + igoClaim.deservedByUser(address(this)));

        mockToken.transfer(address(igoClaim), igoClaim.deservedByUser(address(this)));
        deal(address(mockToken), address(this), 0);

        skip(43200);

        vm.expectRevert(RefundPeriodEnded.selector);
        igoClaim.askForRefund();
    }

    function test_maxDeservedAllocation() public {
        skip(rewardsDuration + 1);
        uint deserved = igoClaim.deservedAllocation(makeAddr("enes"));
        uint deserved2 = igoClaim.deservedAllocation(makeAddr("enes2"));
        console2.log(deserved, deserved2);

        assert(deserved <= totalDollars);
        assert(deserved2 <= totalDollars);
        assert(deserved == deserved2);
        assert(deserved + deserved2 <= totalDollars);
    }


}
