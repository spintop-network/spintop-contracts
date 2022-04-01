async function main() {
  const spinAddress = "0x6AA217312960A21aDbde1478DC8cBCf828110A67";
  const partnerAddress = "0x154A9F9cbd3449AD22FDaE23044319D6eF2a1Fab";
  const pool = "0x084b528744117564D35c3879e7557D80f95465CD";
  const farm = "0xf6F2e973D05A2FFeB2984293e6dfCbA55a6579CE";

  const spinAmount = ethers.utils.parseEther("952380");
  const skillAmount = ethers.utils.parseEther("11516");

  const SpinStakable = await ethers.getContractFactory("SpinStakable");
  //   const farmContract = await SpinStakable.attach(farm);
  const poolContract = await SpinStakable.attach(pool);

  //   const ERC20 = await ethers.getContractFactory("ERC20");
  //   const spinToken = await ERC20.attach(spinAddress);
  //   const skillToken = await ERC20.attach(partnerAddress);

  //   await spinToken.transfer(farm, spinAmount);
  //   console.log("Transferred spin.")
  //   await skillToken.transfer(pool, skillAmount);
  //   console.log("Transferred skill.")

  //   farmContract.notifyRewardAmount(spinAmount);
  //   console.log("Notified farm.")

  await poolContract.notifyRewardAmount(skillAmount);
  console.log("Notified pool.");
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
