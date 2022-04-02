async function main() {
  const SpinVault = await ethers.getContractFactory("IGOVault");
  const spinVault = SpinVault.attach(
    "0x1311F4e5b71bAa84f6e0F0646F3Bc1CAD0B620c1"
  );
  const fakeBUSD = "0xd79f68fe4683aeF1fa5242d435EbfB3C1063d4A9";

  const cmdPause = await spinVault.pause();
  await cmdPause.wait();
  console.log("Paused.");

  const cmdCreate = await spinVault.createIGO(
    "Test IGO #4", // IGO Name
    ethers.utils.parseEther("150000"), // Total Dollars
    fakeBUSD, // Payment token
    "2", // Price (integer)
    "2", // Price (decimal count)
    "1200", // Duration of IGO
    "1" // Public buy multiplier
  );
  await cmdCreate.wait();
  console.log("Created IGO.");
  const igoAddress = await spinVault.IGOs("1");
  console.log("IGO address: ", igoAddress);

  const members = await spinVault.membersLength();
  const batchCount = Math.floor(members / 50) + 1;

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
