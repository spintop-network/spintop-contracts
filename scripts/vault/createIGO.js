async function main() {
  const SpinVault = await ethers.getContractFactory("IGOVault");
  const spinVault = SpinVault.attach(
    "0x03447d28FC19cD3f3cB449AfFE6B3725b3BCdA77"
  );
  const BUSD = "0xe9e7CEA3DedcA5984780Bafc599bD69ADd087D56";
  const igoId = 0; // Set correct id!

  // const cmdPause = await spinVault.pause();
  // await cmdPause.wait();
  // console.log("Paused.");

  // const cmdCreate = await spinVault.createIGO(
  //   "Bountie Hunter", // IGO Name
  //   ethers.utils.parseEther("130000"), // Total Dollars
  //   BUSD, // Payment token (dollars)
  //   "2", // Price (integer)
  //   "2", // Price (decimal count)
  //   "93600", // Duration of IGO (contribution round)
  //   "2" // Public buy multiplier
  // );
  // await cmdCreate.wait();
  // console.log("Created IGO.");
  // const igoAddress = await spinVault.IGOs(igoId);
  // console.log("IGO address: ", igoAddress);

  const cmdBatch = await spinVault.setBatchSize("200");
  await cmdBatch.wait();
  console.log("Batch sized.");

  const members = await spinVault.membersLength();
  const batchCount = Math.floor(members / 200) + 1;

  // const cmdStart = await spinVault.start();
  // await cmdStart.wait();
  for (let i = 0; i < batchCount - 1; i++) {
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
