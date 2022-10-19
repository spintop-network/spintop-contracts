async function main() {
  const spinAddress = "0x6AA217312960A21aDbde1478DC8cBCf828110A67";
  const triviaAddress = "0xb465f3cb6Aba6eE375E12918387DE1eaC2301B05";

  const SpinStakable = await ethers.getContractFactory("SpinStakableDecimal");
  const spinStakable = await SpinStakable.deploy(triviaAddress, spinAddress);
  await spinStakable.deployed();

  console.log("Staking Pool deployed: ", spinStakable.address);
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
