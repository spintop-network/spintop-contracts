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

    for (let i = 0; i < accList.length; i++) {
      let x = Math.floor(1000 + Math.random() * 15000).toString();
      await mock20.transfer(
        accList[i].address,
        ethers.utils.parseEther("50000")
      );
      await mock20
        .connect(accList[i])
        .approve(spinVault.address, ethers.constants.MaxUint256);
      await spinVault.connect(accList[i]).deposit(ethers.utils.parseEther(x));

      let b = ethers.utils.formatEther(
        await spinVault.connect(accList[i]).balanceOf(accList[i].address)
      );
      console.log(i, ": ", b);
    }

    await mock20.transfer(farm.address, ethers.utils.parseEther("100000"));
    await farm.notifyRewardAmount(ethers.utils.parseEther("100000"));
    console.log("Rewards notified.");

    await spinVault.pause();
    await spinVault.createIGO(
      "Spinstarter King",
      ethers.utils.parseEther("150000"),
      mock20.address,
      "2", // price
      "2", // priceDecimal
      "1200", // duration
      "1" // publicBuyMultiplier
    );
    const members = await spinVault.membersLength();
    console.log("Members length: ", members);
    const batchCount = Math.floor(members / 50) + 1;
    console.log("Batch count: ", batchCount);
    await spinVault.start();
    for (let i = 0; i < batchCount; i++) {
      await spinVault.migrateBalances();
    }
    const igo = await spinVault.IGOs(0);
    console.log("First IGO's address: ", igo);
    await spinVault.unpause();

    await spinVault.setPeriods(igo, "4800", "96000");

    for (let i = 0; i < accList.length; i++) {
      let x = Math.floor(1000 + Math.random() * 500).toString();
      await mock20
        .connect(accList[i])
        .approve(spinVault.address, ethers.constants.MaxUint256);
      await spinVault.connect(accList[i]).deposit(ethers.utils.parseEther(x));
      let b = ethers.utils.formatEther(
        await spinVault.connect(accList[i]).balanceOf(accList[i].address)
      );
      console.log(i, ": ", b);
    }

    const IGO = await ethers.getContractFactory("IGO");
    const igo_ = IGO.attach(igo);

    let totalEarned = 0;
    for (let i = 0; i < accList.length; i++) {
      let x = Math.floor(Math.random() * 200);
      await network.provider.send("evm_increaseTime", [x]);
      await network.provider.send("evm_mine");
      console.log(i, " Loop");
      await spinVault.connect(accList[i]).withdraw();
      let earned = await igo_.earned(accList[i].address);
      totalEarned += parseFloat(ethers.utils.formatEther(earned));
      console.log("Earned: ", earned);
      const stateOfIgo = await igo_.IGOstate();
      console.log("IGO state: ", stateOfIgo, "\n\n");
    }

    console.log("Total earned: ", totalEarned);
    const totalSupply = ethers.utils.formatEther(await igo_._totalSupply());
    console.log("IGO TotalSupply: ", totalSupply);
    const totalDollars = ethers.utils.formatEther(await igo_.totalDollars());
    console.log("IGO TotalDollars: ", totalDollars);
    const startDate = await igo_.startDate();
    console.log("StartDate: ", startDate);
    const lastRewardTime = await igo_.lastTimeRewardApplicable();
    console.log("Last Reward at: ", lastRewardTime);
    const stateOfIgo = await igo_.IGOstate();
    console.log("IGO state: ", stateOfIgo, "\n\n");
    const left = ethers.utils.formatEther(await spinVault.balance());
    console.log("Left in vault+pool: ", left);
    const leftVault = ethers.utils.formatEther(await spinVault.vaultBalance());
    console.log("Left in vault alone: ", leftVault);
    const earned = ethers.utils.formatEther(
      await farm.earned(spinVault.address)
    );
    console.log("Current earned of vault: ", earned);
    const leftBalance = ethers.utils.formatEther(
      await farm.balanceOf(spinVault.address)
    );
    console.log("Current balance of vault in pool: ", leftBalance);

    const ClaimContract = await ethers.getContractFactory("IGOClaim");
    const claimAddress = await igo_.claimContract();
    const claimContract = ClaimContract.attach(claimAddress);

    for (let i = 0; i < accList.length; i++) {
      let x = Math.floor(Math.random() * 500);
      await network.provider.send("evm_increaseTime", [x]);
      await network.provider.send("evm_mine");
      const deserved = ethers.utils.formatEther(
        await claimContract.deservedAllocation(accList[i].address)
      );
      console.log("Deserved: ", deserved);
      await mock20
        .connect(accList[i])
        .approve(claimContract.address, ethers.constants.MaxUint256);
      await claimContract
        .connect(accList[i])
        .payForTokens(ethers.utils.parseEther((deserved / 2).toString()));
      const userPaid = await claimContract.paidAmounts(accList[i].address);
      console.log("User paid: ", userPaid, "");

      const claimState = await claimContract.getState();
      console.log("Claim state: ", claimState);

      const totalPaid = ethers.utils.formatEther(
        await claimContract.totalPaid()
      );
      console.log("Total paid: ", totalPaid, "\n");
    }

    await network.provider.send("evm_increaseTime", [15000]);
    await network.provider.send("evm_mine");
    const claimState = await claimContract.getState();
    console.log("Claim state: ", claimState);

    let totalPaid_ = 0;
    for (let i = 0; i < accList.length; i++) {
      const deserved = ethers.utils.formatEther(
        await claimContract.deservedAllocation(accList[i].address)
      );
      await claimContract
        .connect(accList[i])
        .payForTokensPublic(ethers.utils.parseEther((deserved / 2).toString()));
      const userPaid = await claimContract.paidAmounts(accList[i].address);
      console.log(
        "User paid: ",
        parseFloat(ethers.utils.formatEther(userPaid))
      );
      totalPaid_ += parseFloat(ethers.utils.formatEther(userPaid));
    }
    console.log("Total paid actual: ", totalPaid_, "\n");

    const gameToken = await Mock20.deploy("GAME1", "GAME1");
    await gameToken.deployed();
    console.log("gameToken deployed: ", gameToken.address);
    await gameToken.transfer(
      claimContract.address,
      ethers.utils.parseEther("10000000")
    );
    await spinVault.setToken(igo_.address, gameToken.address, 18);

    // first vesting
    await spinVault.notifyVesting(igo_.address, 2000);
    console.log("Notified vesting #1.");
    let totalClaimed = 0;
    for (let i = 0; i < accList.length; i++) {
      await claimContract.connect(accList[i]).claimTokens();
      const userClaimed = await claimContract.claimedAmounts(
        accList[i].address
      );
      console.log(
        "User claimed: ",
        parseFloat(ethers.utils.formatEther(userClaimed))
      );
      totalClaimed += parseFloat(ethers.utils.formatEther(userClaimed));
    }
    console.log("\nTotal claimed: ", totalClaimed, "\n\n");

    // second vesting
    await spinVault.notifyVesting(igo_.address, 10000);
    console.log("Notified vesting #2.");
    for (let i = 0; i < accList.length; i++) {
      await claimContract.connect(accList[i]).claimTokens();
    }
    const totalClaimed2 = ethers.utils.formatEther(
      await claimContract.totalClaimed()
    );
    console.log("\nTotal claimed: ", totalClaimed2);

    await network.provider.send("evm_increaseTime", [20000]);
    await network.provider.send("evm_mine");
    const dollarsLeft = await claimContract.totalPaid();
    console.log("Dollars left: ", dollarsLeft);
    // const tx1 = await spinVault.withdrawIGOFunds(igo_.address, 0);
    // console.log(tx1);
    // const tx2 = await spinVault.withdrawIGOFunds(igo_.address, 1);
    // console.log(tx2);
  });
});
