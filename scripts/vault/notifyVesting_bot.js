async function main() {
  const SpinVault = await ethers.getContractFactory("IGOVault");
  const spinVault = SpinVault.attach(
    "0x03447d28FC19cD3f3cB449AfFE6B3725b3BCdA77"
  );

  const igoId = 0; // Unique IGO id
  const percentage = 5000; // tenthousandths
  const target = 1653013800;
  let notified = false;

  setInterval(async () => {
    let now = Date.now();
    now = parseInt(now / 1000);
    if (now >= target && !notified) {
      const igoAddress = await spinVault.IGOs(igoId);
      const cmdNotifyVesting = await spinVault.notifyVesting(
        igoAddress,
        percentage
      );
      await cmdNotifyVesting.wait();
      console.log("Notified vesting @", now);
      notified = true;
    }
  }, 60000);
}
main();
