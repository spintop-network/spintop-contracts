const { ethers } = require("hardhat");

async function main() {
  const SpinVault = await ethers.getContractFactory("IGOVault");
  const spinVault = SpinVault.attach(
    "0xAdea083E4c3dD1f1EDF3206479378D8894B1ca66"
  );

  await spinVault.deposit(ethers.utils.parseEther("1000"));
  console.log("Deposited 1000 SPIN.");
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
