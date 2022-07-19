async function main() {
  const Farm = await ethers.getContractFactory("SpinStakable");
  const farm = Farm.attach("0x25ab8675C57B4A6Da14677e1353bC59d613F69b5");
  const pool = Farm.attach("0x4Fc1F5EF6886a446637FFfF76F8C4D79EDF395CF");
  const farmAmount = ethers.utils.parseEther("325000");
  const poolAmount = ethers.utils.parseEther("130000");
  const notifyFarm = await farm.notifyRewardAmount(farmAmount);
  await notifyFarm.wait();
  console.log("Farm notified.");
  const notifyPool = await pool.notifyRewardAmount(poolAmount);
  await notifyPool.wait();
  console.log("Pool notified.");
}
main();
