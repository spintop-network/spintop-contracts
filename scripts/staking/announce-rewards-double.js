async function main() {
  const Farm = await ethers.getContractFactory("MultiStaking");
  const farm = Farm.attach("0x10e66c37b81858Cf8377f766B6DFb5af6700A73C");
  const rewardAmount = ethers.utils.parseEther("238000");
  const bonusAmount = ethers.utils.parseUnits("2880000", 9);
  const notifyFarm = await farm.notifyRewardAmount(rewardAmount, bonusAmount);
  await notifyFarm.wait();
  console.log("Farm notified.");
}
main();
