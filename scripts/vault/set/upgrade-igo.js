const hardhat = require("hardhat");
const { ethers, upgrades } = hardhat;

async function main() {
  const igoContract = await ethers.getContractFactory("IGO");
  const igoContractInstance = await upgrades.upgradeProxy(
    "0x8518B39eE5a416654D2F7Ae4aaDD48089c8Eb3E2", // Proxy address
    igoContract
  );
  // await spinVault.waitForDeployment();
  console.log("IGO upgraded: ", igoContractInstance.target);
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
