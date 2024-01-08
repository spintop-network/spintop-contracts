async function main() {
  const SpinVault = await ethers.getContractFactory("IGOVault");
  const spinVault = SpinVault.attach("0x7585C090C772A7bd5dAcAe3495BE615BcA868002");

  const igoId = 10; // Unique IGO id
  const percentage = 2500; // tenthousandths

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
