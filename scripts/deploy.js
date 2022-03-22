async function main() {
  const spinPartnerLP = "0x3860da8D5C595F5E1F8E1f553554bA28691dE5bc";
  const spinAddress = "0x6AA217312960A21aDbde1478DC8cBCf828110A67";
  const partnerAddress = "0x496cC0b4ee12Aa2AC4c42E93067484e7Ff50294b";

  const SpinStakable = await ethers.getContractFactory("SpinStakable");
  const spinStakable = await SpinStakable.deploy(spinAddress, spinPartnerLP);
  await spinStakable.deployed();

  console.log("Staking Pool deployed: ", spinStakable.address);
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
