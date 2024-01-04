const { upgrades } = require("hardhat");
async function main() {
  const spinVaultInstance = await ethers.getContractFactory("IGOVault");
  const spinVaultAddress = "0x7585c090c772a7bd5dacae3495be615bca868002";
  const spinVault = spinVaultInstance.attach(spinVaultAddress);
  const BUSD = "0x8d008B313C1d6C7fE2982F62d32Da7507cF43551";

  const cmdPause = await spinVault.pause();
  await cmdPause.wait();
  console.log("Paused.");

  const igo = await ethers.getContractFactory("IGO");
  const igoInstance = await upgrades.deployProxy(
    igo,
    [
      "Test IGO", // IGO Name
      ethers.parseEther("10000"), // Total Dollars
      "300", // Duration of IGO (contribution round)
      spinVaultAddress
    ],
  );
  await igoInstance.waitForDeployment();
  const igoAddress = await igoInstance.getAddress();
  console.log("IGO deployed: ", igoAddress);

  const cmdCreateIGO = await spinVault.createIGO(igoAddress);
  await cmdCreateIGO.wait();

  const igoClaim = await ethers.getContractFactory("IGOClaim");
  const igoClaimInstance = await upgrades.deployProxy(
    igoClaim,
    [
      spinVaultAddress,
      igoAddress,
      ethers.parseEther("10000"), // Total Dollars
      BUSD, // Payment token (dollars),
      "10", // Price (integer)
      "3", // Price (decimal count)
      "2", // Public buy multiplier
      true, // Is linear?
      igoAddress
    ],
  );

  await igoClaimInstance.waitForDeployment();
  const igoClaimAddress = await igoClaimInstance.getAddress();
  console.log("IGOClaim deployed: ", igoClaimAddress);

  const cmdSetClaim = await spinVault.setClaimContract(igoClaimAddress);
  await cmdSetClaim.wait();
  console.log("Claim contract set.");

  const cmdBatch = await spinVault.setBatchSize("200");
  await cmdBatch.wait();
  console.log("Batch sized.");

  const members = await spinVault.membersLength();
  const batchCount = Math.floor(Number(members) / 200) + 1;

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
