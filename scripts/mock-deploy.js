const { ethers } = require("hardhat");

async function main() {
  // const SpinMock = await ethers.getContractFactory("Mock20");
  // const spinMock = await SpinMock.deploy("ErcanCoin", "ERCAI");
  // await spinMock.deployed();
  // const mockAddress = spinMock.address;
  // console.log("ErcanCoin deployed: ", mockAddress);

  const mockAddress = "0x477bC8d23c634C154061869478bce96BE6045D12";
  const spinAddress = "0x6AA217312960A21aDbde1478DC8cBCf828110A67";

  const SpinStakable = await ethers.getContractFactory("SpinStakable");
  const spinStakable = await SpinStakable.deploy(mockAddress, spinAddress);
  await spinStakable.deployed();
  console.log("SpinStakable deployed: ", spinStakable.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
