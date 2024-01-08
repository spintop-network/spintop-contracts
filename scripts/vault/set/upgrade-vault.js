const hardhat = require("hardhat");
const { ethers, upgrades } = hardhat;

async function main() {
  const SpinVaultContract = await ethers.getContractFactory("IGOVault");
  const spinVault = await upgrades.upgradeProxy(
    "0x7585c090c772a7bd5dacae3495be615bca868002", // Proxy address
    SpinVaultContract
  );
  // await spinVault.waitForDeployment();
  console.log("SpinVault upgraded: ", spinVault.target);
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
