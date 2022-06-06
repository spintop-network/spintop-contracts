async function main() {
  const spinAddress = "0x6AA217312960A21aDbde1478DC8cBCf828110A67";
  const creo = "0x9521728bF66a867BC65A93Ece4a543D817871Eb7";
  const lp = "0x80E7a67a285fb73c27C612502219f5612d91c126";

  const SpinStakable = await ethers.getContractFactory("SpinStakable");
  const spinStakable = await SpinStakable.deploy(creo, spinAddress);
  await spinStakable.deployed();

  console.log("Staking Pool deployed: ", spinStakable.address);
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
