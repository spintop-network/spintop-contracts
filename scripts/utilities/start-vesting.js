async function main() {
  const SpinVault = await ethers.getContractFactory("IGOLinearVesting");
  const spinVault = SpinVault.attach(
    "0xbcE4F20A1E41B64Ef9fB03d1cc0b06743eC7Fe52",
  );

  const cmdSetPeriods = await spinVault.start();
  await cmdSetPeriods.wait();
  console.log("vesting started.");
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
