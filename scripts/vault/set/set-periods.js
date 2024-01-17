async function main() {
  const SpinVault = await ethers.getContractFactory("IGOVault");
  const spinVault = SpinVault.attach(
    "0x7585C090C772A7bd5dAcAe3495BE615BcA868002",
  );

  const igoId = 9; // Unique IGO id
  const allocationPeriod = 120; // in seconds
  const publicPeriod = 120; // in seconds

  const igoAddress = await spinVault.IGOs(igoId);
  const cmdSetPeriods = await spinVault.setPeriods(
    igoAddress,
    allocationPeriod,
    publicPeriod,
  );
  await cmdSetPeriods.wait();
  console.log("Set periods.");
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
