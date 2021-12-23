const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Test Deploy", function () {
  it("Minimum functional deploy.", async function () {
    const SpinMock = await ethers.getContractFactory("SpinMock");
    const spinMock = await SpinMock.deploy();
    await spinMock.deployed();
    const mockAdress = spinMock.address;
    console.log("SpinMock deployed: ", mockAdress);

    const SpinStakable = await ethers.getContractFactory("SpinStakable");
    const spinStakable = await SpinStakable.deploy(mockAdress, mockAdress);
    await spinStakable.deployed();
    console.log("SpinStakable deployed: ", spinStakable.address);

    spinStakable.setRewardsDuration(30);
    expect(await spinStakable.rewardsDuration()).to.equal(30);

    const erc20 = await ethers.getContractFactory("ERC20");
    

    spinStakable.stake()
  });
});
