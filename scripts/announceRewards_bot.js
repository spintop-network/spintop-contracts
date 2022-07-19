async function main() {
  const Farm = await ethers.getContractFactory("SpinStakable");
  const farm = Farm.attach("0x6940992baBF231fDC55F72D74A88384c7120263B");
  const pool = Farm.attach("0xb57438F94feeB207Cf60b2f2dB0178EE888618E5");
  const target = 1656263378;
  const farmAmount = ethers.utils.parseEther("608676");
  const poolAmount = ethers.utils.parseEther("149023");
  let notified = false;
  setInterval(async () => {
    let now = Date.now();
    now = parseInt(now / 1000);
    if (now >= target && !notified) {
      const notifyFarm = await farm.notifyRewardAmount(farmAmount);
      await notifyFarm.wait();
      console.log("Farm notified.");
      const notifyPool = await pool.notifyRewardAmount(poolAmount);
      await notifyPool.wait();
      console.log("Pool notified.");
      notified = true;
    }
  }, 60000);
}
main();
