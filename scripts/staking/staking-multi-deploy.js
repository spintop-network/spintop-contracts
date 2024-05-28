async function main() {
  const spinAddress = "0x6AA217312960A21aDbde1478DC8cBCf828110A67";
  const tokenAddress = "0x62823659d09F9F9D2222058878f89437425eB261";
  const lpAddress = "0x591E3322b89d35Bb2A96B326bE55A07187BC7fb9";

  const SpinStakable = await ethers.getContractFactory("MultiStaking");
  const spinStakable = await SpinStakable.deploy(
    lpAddress,
    spinAddress,
    tokenAddress,
  );
  await spinStakable.waitForDeployment();

  console.log("Staking Pool deployed: ", spinStakable.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
