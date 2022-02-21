async function main() {
  // const SpinMock = await ethers.getContractFactory("SpinMock");
  // const spinMock = await SpinMock.deploy("Kodegon", "KDG");
  // await spinMock.deployed();
  // const mockAdress = spinMock.address;
  // console.log("Kodegon deployed: ", mockAdress);

  const spinAddress = "0x6AA217312960A21aDbde1478DC8cBCf828110A67";
  const lpAddress = "0x544A5FFEabf619f08527B2D4995D0ccb426dBb5c";

  const SpinStakable = await ethers.getContractFactory("SpinStakable");
  const spinStakable = await SpinStakable.deploy(spinAddress, lpAddress);
  await spinStakable.deployed();
  console.log("AOT Staking Pool deployed: ", spinStakable.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
