const hardhat = require("hardhat");
const { ethers, upgrades } = hardhat;

async function main() {
  const poolAddress = "0x06F2bA50843e2D26D8FD3184eAADad404B0F1A67";
  const spinAddress = "0x6AA217312960A21aDbde1478DC8cBCf828110A67";
  const owner = "0xF04a7d27F93f48B69e5C846097D21F52806BC135";
  const SpinVaultContract = await ethers.getContractFactory("IGOVault");
  const spinVault = await upgrades.deployProxy(
    SpinVaultContract,
    [
      "SpinStarter Vault Shares v2",
      "SSvS",
      poolAddress,
      spinAddress,
      owner
    ],
  );
  await spinVault.waitForDeployment();
  console.log("SpinVault deployed: ", await spinVault.getAddress());
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
