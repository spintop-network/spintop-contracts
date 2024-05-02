const hardhat = require("hardhat");
const { ethers, upgrades } = hardhat;

async function main() {
  const igoClaimContract = await ethers.getContractFactory("MerkledIGOClaim");
  const igoClaimContractInstance = await upgrades.upgradeProxy(
    "0xa399E79Dda03326c4BdC0d90D37e4BdcfA2bf89f", // Proxy address
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
