const { ethers } = require("hardhat");

async function main() {
  const Mock20 = await ethers.getContractFactory("ERC20Mock");
  const mock20 = await Mock20.deploy("FaekUSD", "FaekUSD");
  await mock20.deployed();
  console.log("FaekUSD token: ", mock20.address);
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
