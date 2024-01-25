const hardhat = require("hardhat");
const CONSTANTS = require("../../constants");

async function main() {
  const isBscTestnet = hardhat.network.name === "bsctestnet";
  const spinVaultAddress = isBscTestnet
    ? CONSTANTS.TESTNET_VAULT_ADDRESS
    : CONSTANTS.BINANCE_VAULT_ADDRESS;
  const SpinVault = await ethers.getContractFactory("IGOVault");
  const spinVault = SpinVault.attach(spinVaultAddress);

  const igoId = 10; // Unique IGO id
  const percentage = 2500; // tenthousandths

  const igoAddress = await spinVault.IGOs(igoId);
  const cmdNotifyVesting = await spinVault.notifyVesting(
    igoAddress,
    percentage,
  );
  await cmdNotifyVesting.wait();
  console.log("Notified vesting.");
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
