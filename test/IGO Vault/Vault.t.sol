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
    error ExceedsUserBalance();

    function setUp() public {
        skip(1704935836);

        // Deploy ERC20 mock token
        mockToken = new MockERC20();
        paymentToken = address(mockToken);
        gameToken = address(mockToken);

        // Deploy the SpinStakable contract
        spinStakable = new SpinStakable(address(mockToken), address(mockToken));
        deal(address(mockToken), address(spinStakable), 50000e18);

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

        vm.expectRevert(AmountIsZero.selector);
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

        igoClaim.payForTokens(deserved + 1);
        assertEq(igoClaim.paidAmounts(address(this)), deserved);
    }

    function test_tryPayPublicMoreThanDeserved() public {
        uint balance = totalDollars + igoVault.minStakeAmount();
        deal(address(mockToken), address(this), balance);
        mockToken.approve(address(igoVault), balance);

        igoVault.deposit(igoVault.minStakeAmount());

        skip(rewardsDuration + allocationPeriod + 1);
        uint deserved = igoClaim.maxPublicBuy(address(this));
        mockToken.approve(address(igoClaim), balance);

        igoClaim.payForTokensPublic(deserved + 1);
        assertEq(igoClaim.paidAmounts(address(this)), deserved);
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

        vm.expectRevert(AllTokensClaimed.selector);
//        vm.expectRevert(LinearVestingNotStarted.selector);
        igoClaim.claimTokens();
    }

    function test_successfulRefund() public {
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
            0,
            0,
            block.timestamp,
            block.timestamp + 43200,
            25
        );

        skip(1);
        deal(address(mockToken), address(this), igoClaim.deservedByUser(address(this)));

        mockToken.transfer(address(igoClaim), igoClaim.deservedByUser(address(this)));
        deal(address(mockToken), address(this), 0);

        assertEq(mockToken.balanceOf(address(this)), 0);
        igoClaim.askForRefund();
        assertEq(mockToken.balanceOf(address(this)), deserved);

        vm.expectRevert(AlreadyRefunded.selector);
        igoClaim.claimTokens();
    }

    function test_successfulTGEUnlock() public {
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
            0,
            0,
            block.timestamp,
            block.timestamp + 43200,
            25
        );

        skip(1);
        deal(address(mockToken), address(this), igoClaim.deservedByUser(address(this)) * 4);

        mockToken.transfer(address(igoClaim), mockToken.balanceOf(address(this)));

        assertEq(mockToken.balanceOf(address(this)), 0);
        igoClaim.claimTokens();
        uint balance1 = mockToken.balanceOf(address(this));

        vm.expectRevert(AllTokensClaimed.selector);
        igoClaim.claimTokens();

        igoVault.setLinearParams(
            address(igo),
            block.timestamp,
            86400,
            block.timestamp,
            block.timestamp + 43200,
            25
        );
        skip(86400);

        igoClaim.claimTokens();
        uint balance2 = mockToken.balanceOf(address(this));
        assertEq(balance1 * 4, balance2);

        vm.expectRevert(AllTokensClaimed.selector);
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
        assert(deserved <= totalDollars);
        assert(deserved2 <= totalDollars);
        assert(deserved == deserved2);
        assert(deserved + deserved2 <= totalDollars);
    }

    function test_partialWithdraw() public {
        skip(10 days);
        address user = makeAddr("partialWithdraw");
        address user2 = makeAddr("partialWithdraw2");
        uint256 balance = 100e18;
        deal(address(mockToken), user, balance);
        deal(address(mockToken), user2, balance);

        uint256 depositAmount = balance;
        uint256 withdrawAmount = 20e18;

        vm.startPrank(user);
        mockToken.approve(address(igoVault), balance);
        igoVault.deposit(depositAmount);
        skip(1 days);
        vm.stopPrank();

        vm.startPrank(user2);
        mockToken.approve(address(igoVault), balance);
        igoVault.deposit(depositAmount);
        skip(1 days);
        igoVault.withdraw(withdrawAmount);
        assertEq(mockToken.balanceOf(user2), withdrawAmount);
        vm.stopPrank();

        vm.startPrank(user);
        assertEq(mockToken.balanceOf(user), depositAmount - balance);
        igoVault.withdraw(withdrawAmount);
        skip(1 days);
        assertEq(igoVault.getUserStaked(user), depositAmount - withdrawAmount);
        igoVault.withdraw(withdrawAmount);
        skip(1 days);
        assertEq(igoVault.getUserStaked(user), depositAmount - withdrawAmount * 2);
        igoVault.withdraw(withdrawAmount);
        skip(1 days);
        assertEq(igoVault.getUserStaked(user), depositAmount - withdrawAmount * 3);
        assertEq(mockToken.balanceOf(user), withdrawAmount * 3);
        vm.stopPrank();
    }

    function test_fullWithdraw() public {
        skip(10 days);
        address user = makeAddr("partialWithdraw");
        address user2 = makeAddr("partialWithdraw2");
        uint256 balance = 100e18;
        deal(address(mockToken), user, balance);
        deal(address(mockToken), user2, balance);

        uint256 depositAmount = balance;
        uint256 withdrawAmount = balance;

        vm.startPrank(user);
        mockToken.approve(address(igoVault), balance);
        igoVault.deposit(depositAmount);
        skip(1 days);
        vm.stopPrank();

        vm.startPrank(user2);
        mockToken.approve(address(igoVault), balance);
        igoVault.deposit(depositAmount);
        skip(1 days);
        igoVault.withdraw(withdrawAmount);
        assertEq(mockToken.balanceOf(user2), withdrawAmount);
        assertEq(igoVault.getUserStaked(user2), 0);
        vm.stopPrank();

        vm.startPrank(user);
        assertEq(mockToken.balanceOf(user), depositAmount - balance);
        igoVault.withdraw(withdrawAmount);
        skip(1 days);
        assertEq(mockToken.balanceOf(user), withdrawAmount);
        assertEq(igoVault.getUserStaked(user), 0);
        vm.stopPrank();
    }

    function test_tryWithdrawExceedingDeposit() public {
        skip(10 days);
        address user = makeAddr("exceedWithdraw");
        uint256 balance = 100e18;
        deal(address(mockToken), user, balance);

        uint256 depositAmount = balance;
        uint256 withdrawAmount = balance + 1;

        vm.startPrank(user);
        mockToken.approve(address(igoVault), balance);
        igoVault.deposit(depositAmount);
        skip(1 days);
        vm.expectRevert(ExceedsUserBalance.selector);
        igoVault.withdraw(withdrawAmount);
        vm.stopPrank();
    }

    function test_tryWithdrawAfterFullWithdraw() public {
        skip(10 days);
        address user = makeAddr("fullWithdrawWithExceed");
        uint256 balance = 100e18;
        deal(address(mockToken), user, balance);

        uint256 depositAmount = balance;
        uint256 withdrawAmount = balance;

        vm.startPrank(user);
        mockToken.approve(address(igoVault), balance);
        igoVault.deposit(depositAmount);
        skip(1 days);
        vm.stopPrank();

        vm.startPrank(user);
        mockToken.approve(address(igoVault), balance);
        igoVault.withdraw(withdrawAmount);
        skip(1 days);
        vm.expectRevert(ExceedsUserBalance.selector);
        igoVault.withdraw(withdrawAmount);
        vm.stopPrank();
    }

    function test_tryZeroWithdraw() public {
        skip(10 days);
        address user = makeAddr("zeroWithdraw");

        vm.startPrank(user);
        vm.expectRevert(AmountIsZero.selector);
        igoVault.withdraw(0);
    }

    function test_fullExit() public {
        skip(10 days);
        address user = makeAddr("exceedWithdraw");
        uint256 balance = 100e18;
        deal(address(mockToken), user, balance);

        uint256 depositAmount = balance;

        vm.startPrank(user);
        mockToken.approve(address(igoVault), balance);
        igoVault.deposit(depositAmount);
        skip(1 days);
        igoVault.exit();
        assertEq(mockToken.balanceOf(user), depositAmount);
        vm.stopPrank();
    }

    function test_tryExitWithoutDeposit() public {
        skip(10 days);
        address user = makeAddr("exceedWithdraw");

        vm.startPrank(user);
        vm.expectRevert(AmountIsZero.selector);
        igoVault.exit();
        vm.stopPrank();
    }

    function test_tryClaimWithZeroClaimPercentage() public {
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
            0,
            0,
            block.timestamp,
            block.timestamp + 43200,
            0
        );

        vm.expectRevert(AllTokensClaimed.selector);
        igoClaim.claimTokens();

        assertEq(igoClaim.deservedByUser(address(this)), 0);

        igoVault.setLinearParams(
            address(igo),
            0,
            0,
            block.timestamp,
            block.timestamp + 43200,
            100
        );

        uint deservedAll = igoClaim.deservedByUser(address(this));

        igoVault.setLinearParams(
            address(igo),
            0,
            0,
            block.timestamp,
            block.timestamp + 43200,
            10
        );

        uint deserved10Percent = igoClaim.deservedByUser(address(this));

        assert(deservedAll > 0);
        assertEq(deservedAll / 10, deserved10Percent);

        uint totalTokens = (totalDollars / price) * 10**priceDecimals;
        totalTokens = (totalTokens / 1e18) * 10**gameTokenDecimal;
        deal(address(mockToken), address(this), igoClaim.deservedByUser(address(this)));

        mockToken.transfer(address(igoClaim), igoClaim.deservedByUser(address(this)));
        deal(address(mockToken), address(this), 0);

        igoClaim.claimTokens();

        assert(mockToken.balanceOf(address(this)) < totalTokens / 10);

    }

    function test_successfulLinearVesting() public {
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
            10
        );

        deal(address(mockToken), address(this), igoClaim.deservedByUser(address(this)) * 10);

        mockToken.transfer(address(igoClaim), igoClaim.deservedByUser(address(this)) * 10);
        assertEq(mockToken.balanceOf(address(this)), 0);

        igoClaim.claimTokens();
        uint tokenBalance = mockToken.balanceOf(address(this));

        vm.expectRevert(AlreadyClaimed.selector);
        igoClaim.askForRefund();

        skip(86400);
        igoClaim.claimTokens();

        vm.expectRevert(AlreadyClaimed.selector);
        igoClaim.askForRefund();

        uint tokenBalance2 = mockToken.balanceOf(address(this));

        assertEq(tokenBalance * 10, tokenBalance2);

        vm.expectRevert(AllTokensClaimed.selector);
        igoClaim.claimTokens();

        skip(86400);

        vm.expectRevert(AllTokensClaimed.selector);
        igoClaim.claimTokens();

    }

    function test_successfulLinearVestingOneSecond() public {
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
            10
        );

        deal(address(mockToken), address(this), igoClaim.deservedByUser(address(this)) * 10);

        mockToken.transfer(address(igoClaim), igoClaim.deservedByUser(address(this)) * 10);
        assertEq(mockToken.balanceOf(address(this)), 0);

        igoClaim.claimTokens();
        uint tokenBalance = mockToken.balanceOf(address(this));

        skip(1);
        igoClaim.claimTokens();
        uint secondClaimTokenBalance = mockToken.balanceOf(address(this));
        assert(secondClaimTokenBalance > tokenBalance);

        skip(1);
        igoClaim.claimTokens();
        uint thirdClaimTokenBalance = mockToken.balanceOf(address(this));
        assert(thirdClaimTokenBalance > secondClaimTokenBalance);

        skip(86400);
        igoClaim.claimTokens();
        uint fourthClaimTokenBalance = mockToken.balanceOf(address(this));
        assert(fourthClaimTokenBalance > thirdClaimTokenBalance);

        skip(86400);
        vm.expectRevert(AllTokensClaimed.selector);
        igoClaim.claimTokens();
        uint fifthClaimTokenBalance = mockToken.balanceOf(address(this));
        assertEq(fifthClaimTokenBalance, fourthClaimTokenBalance);
    }
}
