async function main() {
  const SpinVault = await ethers.getContractFactory("IGOVault");
  const spinVault = SpinVault.attach("0x03447d28FC19cD3f3cB449AfFE6B3725b3BCdA77");

  const igoId = 5; // Unique IGO id
  const allocationPeriod = 28800; // in seconds
  const publicPeriod = 14400; // in seconds

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
