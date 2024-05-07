const hardhat = require("hardhat");
const { ethers, upgrades } = hardhat;

async function main() {
  const igoClaimContract = await ethers.getContractFactory("IGOClaim");
  const igoClaimContractInstance = await upgrades.upgradeProxy(
    "0xFD4122c5D3c2876a04131F81005b5d323ddB798F", // Proxy address
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
