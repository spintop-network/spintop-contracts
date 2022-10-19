async function main() {
  const spinAddress = "0x6AA217312960A21aDbde1478DC8cBCf828110A67";
  const samuraiAddress = "0x3Ca994D9f723736381d44388bC8dD1e7eE8C1653";
  const lpAddress = "0xEFEd8E9170B99c6cdDDe4C0dB928C550573D5e3A";

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
