async function main() {
  const SpinVault = await ethers.getContractFactory("IGOVault");
  const spinVault = SpinVault.attach(
    "0xAdea083E4c3dD1f1EDF3206479378D8894B1ca66"
  );
  const fakeBUSD = "0xd79f68fe4683aeF1fa5242d435EbfB3C1063d4A9";
  const igoId = 10; // Set correct id!

  const cmdPause = await spinVault.pause();
  await cmdPause.wait();
  console.log("Paused.");

  const cmdCreate = await spinVault.createIGO(
    "Test IGO #11", // IGO Name
    ethers.utils.parseEther("170000"), // Total Dollars
    fakeBUSD, // Payment token (dollars)
    "4", // Price (integer)
    "2", // Price (decimal count)
    "600", // Duration of IGO (contribution round)
    "2" // Public buy multiplier
  );
  await cmdCreate.wait();
  console.log("Created IGO.");
  const igoAddress = await spinVault.IGOs(igoId);
  console.log("IGO address: ", igoAddress);

  const members = await spinVault.membersLength();
  const batchCount = Math.floor(members / 500) + 1;

  const cmdStart = await spinVault.start();
  await cmdStart.wait();
  for (let i = 0; i < batchCount; i++) {
    const cmdMigrate = await spinVault.migrateBalances();
    await cmdMigrate.wait();
    console.log("Migrated batch.");
  }
  const cmdUnpause = await spinVault.unpause();
  await cmdUnpause.wait();
  console.log("Unpaused.");
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
