const hre = require("hardhat");

async function main() {
  const fetcher = await hre.ethers.deployContract("PoolFarmFetcher");

  await fetcher.waitForDeployment();

  console.log("PoolFarmFetcher deployed to:", fetcher.target);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
