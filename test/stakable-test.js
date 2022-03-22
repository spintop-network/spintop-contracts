describe("SpinStakable", function () {
  it("Should distribute rewards linearly", async function () {
    const [owner, addr1, addr2] = await ethers.getSigners();

    const Mock20 = await ethers.getContractFactory("ERC20Mock");
    const reward = await Mock20.deploy("Mock1", "M1");
    await reward.deployed();
    const staked = await Mock20.deploy("Mock2", "M2");
    await staked.deployed();
    const SpinStakable = await ethers.getContractFactory("SpinStakable");
    const spinStakable = await SpinStakable.deploy(
      reward.address,
      staked.address
    );
    await spinStakable.deployed();
    console.log("Farm deployed: ", spinStakable.address);

    await reward.transfer(
      spinStakable.address,
      ethers.utils.parseEther("10000")
    );
    await staked.approve(spinStakable.address, ethers.constants.MaxUint256);
    await spinStakable.stake(ethers.utils.parseEther("1000"));
    await spinStakable.notifyRewardAmount(ethers.utils.parseEther("10000"));
    const e1 = await spinStakable.earned(owner.address);
    console.log("Earned at t0: ", e1);

    await staked.transfer(addr1.address, ethers.utils.parseEther("10000"));
    await staked
      .connect(addr1)
      .approve(spinStakable.address, ethers.constants.MaxUint256);
    await spinStakable.connect(addr1).stake(ethers.utils.parseEther("1000"));

    await network.provider.send("evm_increaseTime", [300]);
    await network.provider.send("evm_mine");
    console.log("5 mins passed.");
    const e2 = await spinStakable.earned(owner.address);
    console.log("Earned at t1: ", e2);

    await network.provider.send("evm_increaseTime", [300]);
    await network.provider.send("evm_mine");
    console.log("5 mins passed.");
    const e3 = await spinStakable.earned(owner.address);
    console.log("Earned at tfinal: ", e3);

    await network.provider.send("evm_increaseTime", [300]);
    await network.provider.send("evm_mine");
    console.log("5 mins passed.");

    await network.provider.send("evm_increaseTime", [300]);
    await network.provider.send("evm_mine");
    console.log("5 mins passed.");

    const e4 = await spinStakable.earned(owner.address);
    console.log("Earned at tafter: ", e4);
    const e5 = await spinStakable.earned(addr1.address);
    console.log("Earned by addr1: ", e5);

    await network.provider.send("evm_increaseTime", [300]);
    await network.provider.send("evm_mine");
    console.log("5 mins passed.");

    await spinStakable.connect(addr1).stake(ethers.utils.parseEther("1000"));
    console.log("Earned by addr1: ", await spinStakable.earned(addr1.address));
    console.log(
      "Balance of addr1: ",
      await spinStakable.balanceOf(addr1.address)
    );
  });
});
