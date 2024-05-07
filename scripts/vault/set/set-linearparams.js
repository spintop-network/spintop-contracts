const hardhat = require("hardhat");
const CONSTANTS = require("../../constants");

async function main() {
  const isBscTestnet = hardhat.network.name === "bsctestnet";
  const SpinVault = await ethers.getContractFactory("IGOVault");
  const spinVaultAddress = isBscTestnet
    ? CONSTANTS.TESTNET_VAULT_ADDRESS
    : CONSTANTS.BINANCE_VAULT_ADDRESS;
  const spinVault = SpinVault.attach(spinVaultAddress);

  const now = Math.floor(Date.now() / 1000);
  const igoId = 9; // Unique IGO id
  const startDate = now;
  const duration = 60;
  const refundStart = 0;
  const refundEnd = 0;
  const percentageUnlocked = 10;
  const tgeStartDate = now;

  const igoAddress = await spinVault.IGOs(igoId);
  const cmdSetPeriods = await spinVault.setLinearParams(
    igoAddress,
    startDate,
    duration,
    refundStart,
    refundEnd,
    percentageUnlocked,
    tgeStartDate,
  );
  await cmdSetPeriods.wait();
  console.log("Set linear params.");
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
