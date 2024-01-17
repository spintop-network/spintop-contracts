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
  const igoId = 4; // Unique IGO id
  const startDate = now;
  const duration = 60 * 30;
  const refundStart = now + 60;
  const refundEnd = now + 60 + 10 * 60;
  const percentageUnlocked = 20;

  const igoAddress = await spinVault.IGOs(igoId);
  const cmdSetPeriods = await spinVault.setLinearParams(
    igoAddress,
    startDate,
    duration,
    refundStart,
    refundEnd,
    percentageUnlocked,
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
