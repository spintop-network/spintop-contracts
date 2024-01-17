const hardhat = require("hardhat");
const CONSTANTS = require("../../constants");
const { ethers, upgrades } = hardhat;

async function main() {
  const isBscTestnet = hardhat.network.name === "bsctestnet";
  const spinVaultAddress = isBscTestnet
    ? CONSTANTS.TESTNET_VAULT_ADDRESS
    : CONSTANTS.BINANCE_VAULT_ADDRESS;
  const SpinVaultContract = await ethers.getContractFactory("IGOVault");
  const spinVault = await upgrades.upgradeProxy(
    spinVaultAddress, // Proxy address
    SpinVaultContract,
  );
  console.log("SpinVault upgraded: ", spinVault.target);
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
