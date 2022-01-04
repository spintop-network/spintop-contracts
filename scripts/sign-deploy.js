const hre = require("hardhat");

async function main() {
  const SignMock = await ethers.getContractFactory("SignMessage");
  const signMock = await SignMock.deploy();
  await signMock.deployed();

  const signAddress = signMock.address;
  console.log("SignMock deployed: ", signAddress);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
