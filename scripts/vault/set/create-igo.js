async function main() {
  const SpinVault = await ethers.getContractFactory("IGOVault");
  const spinVault = SpinVault.attach("0xF4A2e75619985CA21860970279E2D608493032d5");
  const BUSD = "0x6c96d72b04EA665bA7147C997457D07beC973593";
  const igoId = 61; // Set correct id!

  const cmdPause = await spinVault.pause();
  await cmdPause.wait();
  console.log("Paused.");

  const cmdCreate = await spinVault.createIGO(
    "erenjotest", // IGO Name
    ethers.parseEther("10000"), // Total Dollars
    BUSD, // Payment token (dollars)
    "10", // Price (integer)
    "3", // Price (decimal count)
    "300", // Duration of IGO (contribution round)
    "2" // Public buy multiplier
  );
  await cmdCreate.wait();
  console.log("Created IGO.");
  const igoAddress = await spinVault.IGOs(igoId);
  console.log("IGO address: ", igoAddress);

  const cmdBatch = await spinVault.setBatchSize("200");
  await cmdBatch.wait();
  console.log("Batch sized.");

  const members = await spinVault.membersLength();
  const batchCount = Math.floor(members / 200) + 1;


  for (let i = 0; i < batchCount ; i++) {
    const cmdMigrate = await spinVault.migrateBalances();
    await cmdMigrate.wait();
    console.log("Migrated batch.");
  }
  const cmdStart = await spinVault.start();
  await cmdStart.wait();
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
