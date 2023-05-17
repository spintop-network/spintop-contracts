async function main() {
  const Farm = await ethers.getContractFactory("SpinStakableDecimal");
  const pool = Farm.attach("0x9E6826bb3D24e4e74449c592Cf9a7919F4210a3A");
  const poolAmount = ethers.utils.parseUnits("1000000", 3);
  const notifyPool = await pool.notifyRewardAmount(poolAmount);
  await notifyPool.wait();
  console.log("Pool notified.");
}
main();
