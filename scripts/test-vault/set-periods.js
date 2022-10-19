async function main() {
  const SpinVault = await ethers.getContractFactory("IGOVault");
  const spinVault = SpinVault.attach(
    "0xAdea083E4c3dD1f1EDF3206479378D8894B1ca66"
  );

  const igoId = 10; // Unique IGO id
  const allocationPeriod = 600; // in seconds
  const publicPeriod = 600; // in seconds

  const igoAddress = await spinVault.IGOs(igoId);
  const cmdSetPeriods = await spinVault.setPeriods(
    igoAddress,
    allocationPeriod,
    publicPeriod
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
