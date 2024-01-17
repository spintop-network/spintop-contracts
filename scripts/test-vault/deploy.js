const { ethers } = require("hardhat");

async function main() {
  const SpinToken = await ethers.getContractFactory("ERC20Mock");
  const spinToken = await SpinToken.deploy("Spin Token", "SPIN");
  await spinToken.deployed();
  console.log("Spin Token deployed:", spinToken.address);

  const SpinStakable = await ethers.getContractFactory("SpinStakable");
  const spinStakable = await SpinStakable.deploy(
    spinToken.address,
    spinToken.address,
  );
  await spinStakable.deployed();
  console.log("Staking Pool deployed: ", spinStakable.address);

  const SpinVaultContract = await ethers.getContractFactory("IGOVault");
  const spinVault = await SpinVaultContract.deploy(
    "SpinStarter Vault Shares",
    "SSvS",
    spinStakable.address,
    spinToken.address,
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
