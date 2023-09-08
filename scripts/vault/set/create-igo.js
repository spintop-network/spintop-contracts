async function main() {
  const SpinVault = await ethers.getContractFactory("IGOVault");
  const spinVault = SpinVault.attach("0x03447d28FC19cD3f3cB449AfFE6B3725b3BCdA77");
  // const BUSD = "0xe9e7CEA3DedcA5984780Bafc599bD69ADd087D56";
  const BUSD = "0x6c96d72b04EA665bA7147C997457D07beC973593";
  const igoId = 6; // Set correct id!

  const cmdPause = await spinVault.pause();
  await cmdPause.wait();
  console.log("Paused.");

  const cmdCreate = await spinVault.createIGO(
    "Test IGO", // IGO Name
    ethers.utils.parseEther("50000"), // Total Dollars
    BUSD, // Payment token (dollars)
    "5", // Price (integer)
    "2", // Price (decimal count)
    "432000", // Duration of IGO (contribution round)
    "5" // Public buy multiplier
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

  for (let i = 0; i < batchCount - 1; i++) {
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
