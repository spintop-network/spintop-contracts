async function main() {
  const SpinVault = await ethers.getContractFactory("IGOVault");
  const spinVault = SpinVault.attach("0xF4A2e75619985CA21860970279E2D608493032d5");

  const igoId = 61; // Unique IGO id
  const allocationPeriod = 300; // in seconds
  const publicPeriod =300; // in seconds

  const igoAddress = await spinVault.IGOs(igoId);
  const cmdSetPeriods = await spinVault.setPeriods(igoAddress, allocationPeriod, publicPeriod);
  await cmdSetPeriods.wait();
  console.log("Set periods.");
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

