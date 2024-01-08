async function main() {
  const SpinVault = await ethers.getContractFactory("IGOVault");
  const spinVault = SpinVault.attach("0x7585C090C772A7bd5dAcAe3495BE615BcA868002");

  const now = Math.floor(Date.now()/1000);
  const igoId = 9; // Unique IGO id
  const startDate = now + 60;
  const duration = 1800;
  const refundStart = now + 60;
  const refundEnd = now + 60 + 20*60;
  const percentageUnlocked = 20;

  const igoAddress = await spinVault.IGOs(igoId);
  const cmdSetPeriods = await spinVault.setLinearParams(
    igoAddress, startDate, duration, refundStart, refundEnd, percentageUnlocked
  );
  await cmdSetPeriods.wait();
  console.log("Set linear params.");
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

