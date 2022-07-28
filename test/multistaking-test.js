const { expect } = require("chai");
const { ethers } = require("hardhat");
describe("MultiStaking Tests", function () {
  it("Should distribute rewards and bonuses linearly when ratio > 1.", async function () {
    const [owner, addr1, addr2] = await ethers.getSigners();

    const Mock20 = await ethers.getContractFactory("ERC20Mock");
    const MockDecimal = await ethers.getContractFactory("ERC20DecimalMock");
    const reward = await Mock20.deploy("Reward", "R");
    await reward.deployed();
    const staked = await Mock20.deploy("Stake", "S");
    await staked.deployed();
    const bonus = await MockDecimal.deploy("Bonus", "B");
    await bonus.deployed();

    const MultiStaking = await ethers.getContractFactory("MultiStaking");
    const multiStaking = await MultiStaking.deploy(
      staked.address,
      reward.address,
      bonus.address
    );
    await multiStaking.deployed();
    console.log("Farm deployed: ", multiStaking.address);

    await reward.transfer(
      multiStaking.address,
      ethers.utils.parseUnits("100000", 18)
    );
    await bonus.transfer(
      multiStaking.address,
      ethers.utils.parseUnits("100000", 9)
    );

    await staked.approve(multiStaking.address, ethers.constants.MaxUint256);
    await multiStaking.stake(ethers.utils.parseEther("100000"));
    await multiStaking.notifyRewardAmount(
      ethers.utils.parseEther("100000"),
      ethers.utils.parseUnits("100000", 9)
    );

    let balanceBonus = 0;
    let balanceReward = 0;
    for (let i = 0; i < 30; i++) {
      await network.provider.send("evm_increaseTime", [86400]);
      await network.provider.send("evm_mine");

      const earnedReward = parseFloat(
        ethers.utils.formatEther(await multiStaking.earned(owner.address))
      );
      const earnedBonus = parseFloat(
        ethers.utils.formatUnits(
          await multiStaking.earnedBonus(owner.address),
          9
        )
      );
      // console.log("Earned reward: ", earnedReward);
      // console.log("Earned bonus: ", earnedBonus);
      await multiStaking.getReward();
      let newbalanceBonus = parseFloat(
        ethers.utils.formatUnits(await bonus.balanceOf(owner.address), 9)
      );
      // console.log("Parsed bonus balance:", newbalanceBonus);
      let newbalanceReward = parseFloat(
        ethers.utils.formatEther(await reward.balanceOf(owner.address))
      );
      // console.log("Parsed reward balance: ", newbalanceReward);
      expect(newbalanceBonus).to.closeTo(balanceBonus + earnedBonus, 0.1);
      expect(newbalanceReward).to.closeTo(balanceReward + earnedReward, 0.1);
      balanceBonus = newbalanceBonus;
      balanceReward = newbalanceReward;
    }
  });
});
