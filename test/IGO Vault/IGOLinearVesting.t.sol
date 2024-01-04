// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.23;

import "forge-std/StdUtils.sol";

import {Test, console2} from "forge-std/Test.sol";
import {IGOLinearVesting} from "../../contracts/IGO Vault/IGOLinearVesting.sol";
import {MockERC20} from "../../lib/forge-std/src/mocks/MockERC20.sol";
import {console} from "forge-std/console.sol";

contract IGOLinearVestingTest is Test {
    IGOLinearVesting public igolinearvesting;
    MockERC20 public mocktoken;
    bytes32[] public myBytes32Array;
    uint256 tokenAmount = 100;
    uint256 totalDollars = 10000;
    uint256 firstClaimTime = block.timestamp + 120;
    uint256 duration = 300;
    uint256 percentageUnlocked = 10;
    bytes32 root = 0x00;
    uint256 refundPeriodStart = 100;
    uint256 refundPeriodEnd = 200;
    address public deployer = 0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496;
    address public recruiter1;
    address public recruiter2;
    address public creator1;
    address public creator2;
    uint256 internal creator1PrivateKey;
    uint256 internal recruiter1PrivateKey;
    uint256 internal creator2PrivateKey;
    uint256 internal recruiter2PrivateKey;
    function setUp() public {
        creator1PrivateKey = 0x50d58c33b59a82f6d0083846a1c5768adfac2c39ba17d65caf9214a27fa0fcb1;
        recruiter1PrivateKey = 0x02cc9f1123333a9111106b9dc1cd76b360c0aa76600b6b5aa73fdc519b4e75b2;
        creator2PrivateKey = 0x35d4f6ec7dedf7002098fa6984b65e35b19f0d82a013ed9df7bf4c4b7f6aac2b;
        recruiter2PrivateKey = 0x99d9e73803f812e7cd8151fb6996144a7c7a73e8534f7df0b53d803582386406;
        recruiter1 = vm.addr(recruiter1PrivateKey);
        recruiter2 = vm.addr(recruiter2PrivateKey);
        creator1 = vm.addr(creator1PrivateKey);
        creator2 = vm.addr(creator2PrivateKey);
        vm.deal(recruiter1, 500 ether);
        vm.deal(recruiter2, 500 ether);
        vm.deal(creator1, 100 ether);
        vm.deal(creator2, 100 ether);
        vm.prank(deployer);
        mocktoken = new MockERC20();
        console2.log("MockToken address: %s", address(mocktoken));
        deal(address(mocktoken), deployer, 1 ether);
        igolinearvesting = new IGOLinearVesting(
            root,
            address(mocktoken),
            tokenAmount,
            firstClaimTime,
            duration,
            percentageUnlocked,
            refundPeriodStart,
            refundPeriodEnd,
            deployer
        );
        vm.prank(deployer);
        mocktoken.transfer(address(igolinearvesting), 1 ether);
    }
    function test_Claim() public {
        //create a bytes32 array
        vm.roll(500);
        vm.warp(1680616584);
        console.log("balance of recruiter1 before: %s", mocktoken.balanceOf(recruiter1));
        vm.prank(recruiter1);
        igolinearvesting.claim(10, myBytes32Array);
        //log token balance of recruiter1
        console.log("balance of recruiter1 after: %s", mocktoken.balanceOf(recruiter1));
        assertEq(mocktoken.balanceOf(recruiter1), 10 * percentageUnlocked / 100);
    }
//    function test_ClaimAfterStart() public {
//        //create a bytes32 array
//        vm.roll(500);
//        igolinearvesting.start();
//        vm.warp(1680616584);
//
//        console.log("balance of recruiter1 before: %s", mocktoken.balanceOf(recruiter1));
//        vm.prank(recruiter1);
//        igolinearvesting.claim(10, myBytes32Array);
//        //log token balance of recruiter1
//        console.log("balance of recruiter1 after: %s", mocktoken.balanceOf(recruiter1));
//        assertEq(mocktoken.balanceOf(recruiter1), 10);
//    }
//    function test_ClaimAfterHalfTime() public {
//        //create a bytes32 array
//        vm.roll(500);
//        igolinearvesting.start();
//        vm.warp(duration / 2 );
//
//        console.log("balance of recruiter1 before: %s", mocktoken.balanceOf(recruiter1));
//        vm.prank(recruiter1);
//        igolinearvesting.claim(10, myBytes32Array);
//        //log token balance of recruiter1
//        console.log("balance of recruiter1 after: %s", mocktoken.balanceOf(recruiter1));
//        assertEq(mocktoken.balanceOf(recruiter1), 5);
//    }
//    function test_ClaimTwoThirdsOfTime() public {
//        //create a bytes32 array
//        vm.roll(500);
//        igolinearvesting.start();
//        vm.warp(duration * 2 / 3 );
//
//        console.log("balance of recruiter1 before: %s", mocktoken.balanceOf(recruiter1));
//        vm.prank(recruiter1);
//        igolinearvesting.claim(30, myBytes32Array);
//        //log token balance of recruiter1
//        console.log("balance of recruiter1 after: %s", mocktoken.balanceOf(recruiter1));
//        assertEq(mocktoken.balanceOf(recruiter1), 20);
//    }
//    function test_Refund() public {
//        //create a bytes32 array
//        vm.roll(500);
//        vm.warp(150);
//        vm.prank(recruiter1);
//        igolinearvesting.askForRefund(10, myBytes32Array);
//        vm.expectRevert();
//        vm.prank(recruiter1);
//        igolinearvesting.claim(10, myBytes32Array);
//
//    }
//
//    function test_Deserved() public {
//        //create a bytes32 array
//        vm.roll(500);
//        vm.warp(150);
//        vm.prank(recruiter1);
//        console.log("Deserved: %s", igolinearvesting.deserved(555000));
//        assertEq(igolinearvesting.deserved(10), 1);
//    }
}
