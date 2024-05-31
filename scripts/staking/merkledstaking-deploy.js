async function main() {
  const rewardToken = "0x8DC0F602696De3fF03B37e19A172e5080f049C15";
  const stakingToken = "0x8DC0F602696De3fF03B37e19A172e5080f049C15";
  const merkleRoot =
    "0xe9398ce6d1fac7d0d11987e4d27ba11e447599fa192963eedbd3637164d5a36a";

  const SpinStakable = await ethers.getContractFactory("MerkledStaking");
  const spinStakable = await SpinStakable.deploy(
    rewardToken,
    stakingToken,
    merkleRoot,
  );
  await spinStakable.waitForDeployment();

  console.log("MerkledStaking Pool deployed: ", spinStakable.target);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
