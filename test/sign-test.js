const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Test Deploy", function () {
  it("Minimum functional deploy.", async function () {
    const SignMock = await ethers.getContractFactory("SignMessage");
    const signMock = await SignMock.deploy();
    await signMock.deployed();

    const signAddress = signMock.address;
    console.log("SignMock deployed: ", signAddress);

    const hashed = await signMock.getEthSignedHash("hello");
    console.log("Hash: ", hashed);
  });
});
