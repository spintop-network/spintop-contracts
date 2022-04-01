async function main() {
  // const spinPartnerLP = "0x013c19e33633df1b2EAcd01D720719F00F0DB007";
  const spinAddress = "0x6AA217312960A21aDbde1478DC8cBCf828110A67";
  const partnerAddress = "0x154a9f9cbd3449ad22fdae23044319d6ef2a1fab";

  const SpinStakable = await ethers.getContractFactory("SpinStakable");
  const spinStakable = await SpinStakable.deploy(partnerAddress, spinAddress);
  await spinStakable.deployed();

  console.log("Staking Pool deployed: ", spinStakable.address);
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
