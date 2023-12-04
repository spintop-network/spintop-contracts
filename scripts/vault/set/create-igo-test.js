async function main() {
    const SpinVault = await ethers.getContractFactory("IGOVault");
    const spinVault = SpinVault.attach("0xc61d8139496b6e42869A585a584082FdCB5d2b33");
    const BUSD = "0x6c96d72b04EA665bA7147C997457D07beC973593";
    const igoId = 1; // Set correct id!
  
    
    const cmdPause = await spinVault.pause();
    await cmdPause.wait();
    console.log("Paused.");
  
    const cmdCreate = await spinVault.createIGO(
      "Aria", // IGO Name
      ethers.utils.parseEther("75000"), // Total Dollars
      BUSD, // Payment token (dollars)
      "35", // Price (integer)
      "3", // Price (decimal count)
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
  
    const cmdStart = await spinVault.start();
    await cmdStart.wait();
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
  