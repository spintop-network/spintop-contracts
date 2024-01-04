const hardhat = require("hardhat");
const { ethers } = hardhat;

async function main() {
  const poolAddress = "0x06F2bA50843e2D26D8FD3184eAADad404B0F1A67";
  const spinAddress = "0x6AA217312960A21aDbde1478DC8cBCf828110A67";
  const SpinVaultContract = await ethers.getContractFactory("IGOVault");
  const spinVault = await SpinVaultContract.deploy(
    "TestVault",
    "test",
    poolAddress,
    spinAddress
  );
  await spinVault.waitForDeployment();
  console.log("SpinVault deployed: ", spinVault.target);
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
