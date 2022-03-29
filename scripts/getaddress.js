const { ethers } = require("hardhat");

async function main() {
  const IGOContract = await ethers.getContractFactory("IGO");
  const igoContract = IGOContract.attach(
    "0x47876d28B79c825E9CB4427c15104C0Ad4D748c1"
  );
  const addr = await igoContract.claimContract();
  console.log("Claim contract: ", addr);
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
