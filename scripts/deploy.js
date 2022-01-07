async function main() {
  const SpinMock = await ethers.getContractFactory("SpinMock");
  const spinMock = await SpinMock.deploy();
  await spinMock.deployed();
  const mockAdress = spinMock.address;
  console.log("SpinMock deployed: ", mockAdress);

  const SpinStakable = await ethers.getContractFactory("SpinStakable");
  const spinStakable = await SpinStakable.deploy(mockAdress, mockAdress);
  await spinStakable.deployed();
  console.log("SpinStakable deployed: ", spinStakable.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
