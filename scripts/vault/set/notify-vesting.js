async function main() {
  const SpinVault = await ethers.getContractFactory("IGOVault");
  const spinVault = SpinVault.attach("0xF4A2e75619985CA21860970279E2D608493032d5");

  const igoId = 46; // Unique IGO id
  const percentage = 1250; // tenthousandths

  const igoAddress = await spinVault.IGOs(igoId);
  const cmdNotifyVesting = await spinVault.notifyVesting(igoAddress, percentage);
  await cmdNotifyVesting.wait();
  console.log("Notified vesting.");
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
