async function main() {
  const [owner] = await ethers.getSigners();

  const VAULT = "0x171a9377c5013bb06bca8cfe22b9c007f2c319f1";
  const AnyERC = await ethers.getContractFactory("AnyswapV5ERC20");
  const anyERC = await AnyERC.deploy(
    "Spintop Network",
    "SPIN",
    18,
    "0x0000000000000000000000000000000000000000",
    owner.address
  );
  await anyERC.deployed();
  console.log("anySPIN deployed: ", anyERC.address);

  await anyERC.initVault(VAULT);

  const owna = await anyERC.owner();
  console.log("Owner after initVault: ", owna);
  const mpc = await anyERC.mpc();
  console.log("MPC after initVault: ", mpc);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
