async function main() {
  const spinAddress = "0x6AA217312960A21aDbde1478DC8cBCf828110A67";
  const samuraiAddress = "";
  const lpAddress = "";

  const SpinStakable = await ethers.getContractFactory("MultiStaking");
  const spinStakable = await SpinStakable.deploy(
    lpAddress,
    spinAddress,
    samuraiAddress
  );
  await spinStakable.deployed();

  console.log("Staking Pool deployed: ", spinStakable.address);
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
