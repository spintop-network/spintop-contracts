const hardhat = require("hardhat");
const { ethers, upgrades } = hardhat;

async function main() {
  const igoClaimContract = await ethers.getContractFactory("IGOClaim");
  const igoClaimContractInstance = await upgrades.upgradeProxy(
    "0xbb4859eC1A3391A80113116A6570031A72F0FE58", // Proxy address
    igoClaimContract,
  );
  // await spinVault.waitForDeployment();
  console.log("IGOClaim upgraded: ", igoClaimContractInstance.target);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
