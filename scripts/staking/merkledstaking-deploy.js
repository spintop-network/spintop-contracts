async function main() {
  const rewardToken = "0x6c96d72b04ea665ba7147c997457d07bec973593";
  const stakingToken = "0x6c96d72b04ea665ba7147c997457d07bec973593";
  const merkleRoot =
    "0x9df10038654ecc26f3ab98aec486c1ccfd08934c58468c59a2b30aa73794389f";

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
