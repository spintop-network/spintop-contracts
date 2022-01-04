const { ethers } = require("hardhat");
const hre = require("hardhat");

async function main() {
  const spinToken = "0x6aa217312960a21adbde1478dc8cbcf828110a67";
  const lpToken = "0x89c68051543fa135b31c2ce7bd8cdf392345ff01";

  const SpinStakable = await ethers.getContractFactory("SpinStakable");
  const spinStakable = await SpinStakable.deploy(spinToken, spinToken);
  await spinStakable.deployed();
  console.log("SpinStakable deployed: ", spinStakable.address);

  const SpinFarm = await ethers.getContractFactory("SpinStakable");
  const spinFarm = await SpinFarm.deploy(spinToken, lpToken);
  await spinFarm.deployed();
  console.log("SpinFarm deployed: ", spinFarm.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
