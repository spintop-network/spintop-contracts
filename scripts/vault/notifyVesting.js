async function main() {
  const SpinVault = await ethers.getContractFactory("IGOVault");
  const spinVault = SpinVault.attach("0x03447d28FC19cD3f3cB449AfFE6B3725b3BCdA77");

  const igoId = 5; // Unique IGO id
  const percentage = 1500; // tenthousandths

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
