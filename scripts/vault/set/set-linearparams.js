async function main() {
  const SpinVault = await ethers.getContractFactory("IGOVault");
  const spinVault = SpinVault.attach("0x22c446155db0ca9c6ec0552df07636ad9bfcb541");

  const now = Math.floor(Date.now()/1000);
  const igoId = 2; // Unique IGO id
  const startDate = now + 60;
  const duration = 1800;
  const refundStart = now + 60;
  const refundEnd = now + 60 + 10*60;
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

