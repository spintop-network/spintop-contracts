const hardhat = require("hardhat");
const { ethers, upgrades } = hardhat;

async function main() {
  const SpinVaultContract = await ethers.getContractFactory("IGOVault");
  const spinVault = await upgrades.upgradeProxy(
    "0x22c446155db0ca9c6ec0552df07636ad9bfcb541", // Proxy address
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
