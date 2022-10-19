const { ethers } = require("hardhat");

async function main() {
  const poolAddress = "0x06F2bA50843e2D26D8FD3184eAADad404B0F1A67";
  const spinAddress = "0x6AA217312960A21aDbde1478DC8cBCf828110A67";
  const SpinVaultContract = await ethers.getContractFactory("IGOVault");
  const spinVault = await SpinVaultContract.deploy(
    "SpinStarter Vault Shares",
    "SSvS",
    poolAddress,
    spinAddress
  );
  await spinVault.deployed();
  console.log("SpinVault deployed: ", spinVault.address);
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
