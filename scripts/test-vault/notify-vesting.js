async function main() {
  const SpinVault = await ethers.getContractFactory("IGOVault");
  const spinVault = SpinVault.attach(
    "0xAdea083E4c3dD1f1EDF3206479378D8894B1ca66"
  );

  const igoId = 4; // Unique IGO id
  const percentage = 10000; // thousandths

  const igoAddress = await spinVault.IGOs(igoId);
  const cmdNotifyVesting = await spinVault.notifyVesting(
    igoAddress,
    percentage
  );
  await cmdNotifyVesting.wait();
  console.log("Notified vesting.");
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
