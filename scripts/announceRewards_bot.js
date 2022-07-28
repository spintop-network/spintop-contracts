async function main() {
  const Farm = await ethers.getContractFactory("SpinStakable");
  const farm = Farm.attach("0x10e66c37b81858Cf8377f766B6DFb5af6700A73C");
  // const pool = Farm.attach("0xa6c1036347243C8ecF488414ba13E2E295702DF4");
  const target = 1659020400;
  const rewardAmount = ethers.utils.parseEther("230000");
  const bonusAmount = ethers.utils.parseUnits("716127", 9);
  // const poolAmount = ethers.utils.parseEther("2871825");
  let notified = false;
  setInterval(async () => {
    let now = Date.now();
    now = parseInt(now / 1000);
    if (now >= target && !notified) {
      const notifyFarm = await farm.notifyRewardAmount(
        rewardAmount,
        bonusAmount
      );
      await notifyFarm.wait();
      console.log("Farm notified.");
      // const notifyPool = await pool.notifyRewardAmount(poolAmount);
      // await notifyPool.wait();
      // console.log("Pool notified.");
      notified = true;
    }
  }, 60000);
}
main();
