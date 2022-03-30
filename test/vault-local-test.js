const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Spinstarter Basic Functionality Test", function () {
  it("Should distribute rewards linearly.", async function () {
    const accList = await ethers.getSigners();

    await network.provider.send("hardhat_setBalance", [
      accList[0].address,
      "0xfffffffffffffffffffffffffff",
    ]);

    const Mock20 = await ethers.getContractFactory("ERC20Mock");
    const mock20 = await Mock20.deploy("fSPIN", "fSPIN");
    await mock20.deployed();
    console.log("Mock20 deployed: ", mock20.address);

    const Farm = await ethers.getContractFactory("SpinStakable");
    const farm = await Farm.deploy(mock20.address, mock20.address);
    await farm.deployed();
    console.log("Farm deployed: ", farm.address);

    // deploy vault
    const SpinVault = await ethers.getContractFactory("IGOVault");
    const spinVault = await SpinVault.deploy(
      "Spinstarter Shares",
      "SSS",
      farm.address,
      mock20.address
    );
    await spinVault.deployed();
    console.log("SpinVault deployed: ", spinVault.address);

    // 20 acc loop
    for (let i = 0; i < 20; i++) {
      let x = Math.floor(1000 + Math.random() * 500).toString();
      // await network.provider.send("evm_increaseTime", [x]);
      // await network.provider.send("evm_mine");
      await mock20.transfer(
        accList[i].address,
        ethers.utils.parseEther("2000")
      );
      await mock20
        .connect(accList[i])
        .approve(spinVault.address, ethers.constants.MaxUint256);
      await spinVault.connect(accList[i]).deposit(ethers.utils.parseEther(x));

      let b = ethers.utils.formatEther(
        await spinVault.connect(accList[i]).getUserStaked(accList[i].address)
      );
      console.log(i, ": ", b);
    }

    await mock20.transfer(farm.address, ethers.utils.parseEther("100000"));
    await farm.notifyRewardAmount(ethers.utils.parseEther("100000"));
    console.log("Rewards notified.");

    await spinVault.createIGO(
      "Spinstarter King",
      ethers.utils.parseEther("200000"),
      mock20.address,
      "1",
      "18000",
      "1"
    );
    const igo = await spinVault.IGOs(0);
    console.log("First IGO's address: ", igo);

    const IGO = await ethers.getContractFactory("IGO");
    const igo_ = IGO.attach(igo);

    // await network.provider.send("evm_increaseTime", [300]);
    // await network.provider.send("evm_mine");

    for (let i = 0; i < 20; i++) {
      let x = Math.floor(Math.random() * 200);
      await network.provider.send("evm_increaseTime", [x]);
      await network.provider.send("evm_mine");
      let balance = await spinVault
        .connect(accList[i])
        .balanceOf(accList[i].address);
      await spinVault.connect(accList[i]).withdraw();
      let r = await mock20.balanceOf(accList[i].address);
      console.log("Withdrawn successfully: ", r);
      let earned = await igo_.earned(accList[i].address);
      console.log("Earned: ", earned);
    }

    for (let i = 0; i < 20; i++) {
      let total = parseInt(
        ethers.utils.formatEther(await mock20.balanceOf(accList[i].address))
      );
      console.log(total);
    }

    const left = ethers.utils.formatEther(await spinVault.balance());
    console.log("Left in vault: ", left);

    // await spinVault.createIGO(
    //   "Spinstarter King",
    //   ethers.utils.parseEther("200000"),
    //   mock20.address,
    //   "1",
    //   "1800",
    //   "1"
    // );
    // const igo = await spinVault.IGOs(0);
    // console.log("First IGO's address: ", igo);
  });
});
