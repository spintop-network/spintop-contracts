const { ethers } = require("hardhat");

async function main() {
  const poolAddress = "0x06F2bA50843e2D26D8FD3184eAADad404B0F1A67";
  const spinAddress = "0x6AA217312960A21aDbde1478DC8cBCf828110A67";
  const SpinVaultContract = await ethers.getContractFactory("IGOVault");
  const spinVault = await SpinVaultContract.deploy(
    "Spinstarter Shares",
    "SSS",
    poolAddress,
    spinAddress
  );
  await spinVault.deployed();
  console.log("SpinVault deployed: ", spinVault.address);

  // await spinVault.transferOwnership(
  //   "0xC370b50eC6101781ed1f1690A00BF91cd27D77c4"
  // );

  const Mock20 = await ethers.getContractFactory("ERC20Mock");
  const mock20 = await Mock20.deploy("Game1", "Game1");
  await mock20.deployed();
  console.log("Game1 token: ", mock20.address);

  const Mock20Decimal = await ethers.getContractFactory("ERC20DecimalMock");
  const mock20Decimal = await Mock20Decimal.deploy("Game2", "Game2");
  await mock20Decimal.deployed();
  console.log("Game2 token (decimal): ", mock20Decimal.address);
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
