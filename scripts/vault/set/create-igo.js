const hardhat = require("hardhat");
const upgrades = hardhat.upgrades;
const CONSTANTS = require("../../constants");
async function main() {
  const isBscTestnet = hardhat.network.name === "bsctestnet";
  const spinVaultInstance = await ethers.getContractFactory("IGOVault");
  const spinVaultAddress = isBscTestnet
    ? CONSTANTS.TESTNET_VAULT_ADDRESS
    : CONSTANTS.BINANCE_VAULT_ADDRESS;
  const spinVault = spinVaultInstance.attach(spinVaultAddress);
  const paymentToken = isBscTestnet
    ? CONSTANTS.TESTNET_SPIN_ADDRESS
    : CONSTANTS.BINANCE_FAKE_BUSD_ADDRESS;
  const gameToken = isBscTestnet
    ? CONSTANTS.TESTNET_SPIN_ADDRESS
    : CONSTANTS.BINANCE_SPIN_ADDRESS;
  const gameTokenDecimal = 18;
  const contributionRoundDuration = "30";
  const allocationPeriod = 120; // in seconds
  const publicPeriod =120; // in seconds
  const totalDollars = ethers.parseUnits("1000", 18);
  const igoName = "Test IGO";
  const price = "10";
  const priceDecimals = "3";
  const priceBuyMultiplier = "2";
  const isLinear = true;

  const cmdPause = await spinVault.pause();
  await cmdPause.wait();
  console.log("Paused.");

  const igo = await ethers.getContractFactory("IGO");
  const igoInstance = await upgrades.deployProxy(
    igo,
    [
      igoName, // IGO Name
      totalDollars, // Total Dollars
      contributionRoundDuration, // Duration of IGO (contribution round)
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
      totalDollars, // Total Dollars
      paymentToken, // Payment token (dollars),
      price, // Price (integer)
      priceDecimals, // Price (decimal count)
      priceBuyMultiplier, // Public buy multiplier
      isLinear, // Is linear?
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

  const cmdStart = await spinVault.start();
  await cmdStart.wait();

  for (let i = 0; i < batchCount ; i++) {
    const cmdMigrate = await spinVault.migrateBalances();
    await cmdMigrate.wait();
    console.log("Migrated batch.");
  }

  const cmdUnpause = await spinVault.unpause();
  await cmdUnpause.wait();
  console.log("Unpaused.");

  const cmdSetPeriods = await spinVault.setPeriods(igoAddress, allocationPeriod, publicPeriod);
  await cmdSetPeriods.wait();
  console.log("Set periods.");

  const cmdSetToken = await spinVault.setToken(igoAddress, gameToken, gameTokenDecimal);
  await cmdSetToken.wait();
  console.log("Set token.");
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
