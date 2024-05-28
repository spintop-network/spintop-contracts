async function main() {
  const triviaAddress = "0xb465f3cb6Aba6eE375E12918387DE1eaC2301B05";

  const Stakable = await ethers.getContractFactory("SpinStakableDecimal");
  const stakable = await Stakable.deploy(triviaAddress, triviaAddress);
  await stakable.waitForDeployment();

  console.log("Staking Pool deployed: ", stakable.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
