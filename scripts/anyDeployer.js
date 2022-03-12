async function main() {
  // fresh deployer account
  // const SPIN_DEPLOYER = "0xe7cA7D974169cc5A7ee19e1cA4C2e919718B7002";
  // await hre.network.provider.request({
  //   method: "hardhat_impersonateAccount",
  //   params: [SPIN_DEPLOYER],
  // });
  // await network.provider.send("hardhat_setBalance", [
  //   SPIN_DEPLOYER,
  //   "0xfffffffffffffffffffffffffff",
  // ]);

  const signer = await ethers.getSigner(SPIN_DEPLOYER);
  const DeployerContract = await ethers.getContractFactory(
    "AnyswapCreate2Deployer"
  );
  const Deployer = DeployerContract.connect(signer);
  const deployer = await Deployer.deploy();
  await deployer.deployed();
  console.log("Deployer deployed: ", deployer.address);
  console.log("Deployed by: ", signer.address);

  const VAULT = "0x171a9377c5013bb06bca8cfe22b9c007f2c319f1";
  const AnyERC_ = await ethers.getContractFactory("AnyswapV6ERC20");
  const AnyERC = AnyERC_.connect(signer);
  const anyERCcode = AnyERC.bytecode;

  await deployer.deploy(
    anyERCcode,
    "Spintop",
    "SPIN",
    18,
    "0x0000000000000000000000000000000000000000",
    SPIN_DEPLOYER,
    42,
    { gasLimit: 10000000 }
  );

  const impAddress = await deployer.implementationAddress();
  console.log("Implementation address: ", impAddress);

  const impContract = AnyERC.attach(impAddress);
  await impContract.initVault(VAULT);
  console.log("Vault initiated.");

  const vaultAddress = await impContract.owner();
  console.log("Vault transfer confirmed.\nNew Address: ", vaultAddress);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
