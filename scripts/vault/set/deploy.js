const hardhat = require("hardhat");
const {
  TESTNET_POOL_ADDRESS,
  BINANCE_POOL_ADDRESS,
  TESTNET_SPIN_ADDRESS,
  BINANCE_SPIN_ADDRESS,
} = require("../../constants");
const { ethers, upgrades } = hardhat;

async function main() {
  const isBscTestnet = hardhat.network.name === "bsctestnet";
  const poolAddress = isBscTestnet
    ? TESTNET_POOL_ADDRESS
    : BINANCE_POOL_ADDRESS;
  const spinAddress = isBscTestnet
    ? TESTNET_SPIN_ADDRESS
    : BINANCE_SPIN_ADDRESS;
  const owner = new ethers.Wallet(hardhat.network.config.accounts[0]).address;
  const SpinVaultContract = await ethers.getContractFactory("IGOVault");
  const spinVault = await upgrades.deployProxy(SpinVaultContract, [
    "SpinStarter Vault Shares v2",
    "SSvS",
    poolAddress,
    spinAddress,
    owner,
  ]);
  await spinVault.waitForDeployment();
  console.log("SpinVault deployed: ", await spinVault.getAddress());
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
