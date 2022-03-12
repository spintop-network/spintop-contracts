async function main() {
  const spinDmlgLP = "0x237734716F1Bba62a9467FbABF26C98735e84DEf";
  const spinAddress = "0x6AA217312960A21aDbde1478DC8cBCf828110A67";
  const dmlgAddress = "0x1c796C140de269E255372ea687EF7644BAb87935";

  const SpinStakable = await ethers.getContractFactory("SpinStakable");
  const spinStakable = await SpinStakable.deploy(dmlgAddress, spinAddress);
  await spinStakable.deployed();

  console.log("Staking Pool deployed: ", spinStakable.address);
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

// DNCX = 0.0746 USD
// SPIN = 0.1311 USD
