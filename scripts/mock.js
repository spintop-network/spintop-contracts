const { ethers } = require("hardhat");

async function main() {
  const Mock20 = await ethers.getContractFactory("ERC20Mock");
  const mock20 = await Mock20.deploy("FaekGame1", "FaekGame1");
  await mock20.deployed();
  console.log("FaekGame1 Token: ", mock20.address);

  const mock202 = await Mock20.deploy("FaekGame2", "FaekGame2");
  await mock202.deployed();
  console.log("FaekGame2 Token: ", mock202.address);
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
