async function main() {
  const SpinVault = await ethers.getContractFactory("IGOLinearVesting");
  const spinVault = SpinVault.attach("0x0e845969C1a04F8D9223634a423DFe1e8C0f44b6");

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

