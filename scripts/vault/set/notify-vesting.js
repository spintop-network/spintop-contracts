const hardhat = require("hardhat");
const CONSTANTS = require("../../constants");

async function main() {
  const isBscTestnet = hardhat.network.name === "bsctestnet";
  const spinVaultAddress = isBscTestnet
    ? CONSTANTS.TESTNET_VAULT_ADDRESS
    : CONSTANTS.BINANCE_VAULT_ADDRESS;
  const SpinVault = await ethers.getContractFactory("IGOVault");
  const spinVault = SpinVault.attach(spinVaultAddress);

  const now = Math.floor(Date.now() / 1000);
  const igoId = 43; // Unique IGO id
  const percentage = 1000; // tenthousandths
  const tgeStartDate = now;

  const igoAddress = await spinVault.IGOs(igoId);

  const cmdRefund = await spinVault.setRefundPeriod(
    igoAddress,
    now,
    now + 60 * 60,
  );
  await cmdRefund.wait();

  const cmdNotifyVesting = await spinVault.notifyVesting(
    igoAddress,
    percentage,
    tgeStartDate,
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
