async function main() {
  const SPIN_DEPLOYER = "0xe7cA7D974169cc5A7ee19e1cA4C2e919718B7002";

  await hre.network.provider.request({
    method: "hardhat_impersonateAccount",
    params: [SPIN_DEPLOYER],
  });
  await network.provider.send("hardhat_setBalance", [
    SPIN_DEPLOYER,
    "0xfffffffffffffffffffffffffff",
  ]);
  const signer = await ethers.getSigner(SPIN_DEPLOYER);

  const Deployer = await ethers.getContractFactory("AnyswapCreate2Deployer");
  // const deployer = await Deployer.deploy();
  const deployer = Deployer.connect(signer);
  const deployerDeployed = await deployer.deploy();
  await deployerDeployed.deployed();
  console.log("Deployer deployed: ", deployerDeployed.address);
  console.log("Deployed by: ", signer.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
