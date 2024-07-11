const hardhat = require("hardhat");
const { ethers, upgrades } = hardhat;

async function main() {
  const igoContract = await ethers.getContractFactory("IGO");
  const igoContractInstance = await upgrades.upgradeProxy(
    "0x1970918662298ed77932096c1ac454B086810b54", // Proxy address
    igoContract,
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
