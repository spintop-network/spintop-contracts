const hardhat = require("hardhat");
const { ethers, upgrades } = hardhat;

async function main() {
  const igoClaimContract = await ethers.getContractFactory("IGOClaim");
  const igoClaimContractInstance = await upgrades.upgradeProxy(
    "0xf80fdc3dd35dfca56bc4507aa9f145681eb69525", // Proxy address
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
