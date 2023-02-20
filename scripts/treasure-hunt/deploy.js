async function main() {
  const Plonk = await ethers.getContractFactory("TurboVerifier");
  const plonk = await Plonk.deploy();
  await plonk.deployed();

  console.log("Plonk: ", plonk.address);
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
