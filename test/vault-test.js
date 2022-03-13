const { ethers } = require("hardhat");

describe("Payment", function () {
  it("Should add new balance", async function () {
    const poolAddress = "0x06F2bA50843e2D26D8FD3184eAADad404B0F1A67";
    const spinAddress = "0x6AA217312960A21aDbde1478DC8cBCf828110A67";
    const [owner] = await ethers.getSigners();
    const SpinVault = await ethers.getContractFactory("SpinVault");
    const spinVault = await SpinVault.deploy(
      "Spinstarter Shares",
      "SSS",
      poolAddress,
      spinAddress
    );
    await spinVault.deployed();
    console.log("SpinVault deployed: ", spinVault.address);

    await spinVault.createIGO("Spinstarter King", "spinKing", 1647162821);

    const igo = await spinVault.getIGO(0);
    console.log("First IGO's address: ", igo);

    //approve vault

    const ERC20 = await ethers.getContractFactory("ERC20");
    const spinToken = ERC20.attach(spinAddress);
    await spinToken.approve(spinVault.address, ethers.constants.MaxUint256);

    await spinVault.deposit(ethers.utils.parseEther("1000"));
    const balance = await spinVault.balance();
    console.log("Total SPIN in vault: ", balance);
    const userBalance = await spinVault.vaultBalanceOf(owner.address);
    console.log("User shares: ", userBalance);
  });
});
