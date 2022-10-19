const { ethers } = require("hardhat");

async function main() {
  const IGO = await ethers.getContractFactory("IGO");
  const igo = IGO.attach("0xD46741501117791bB7f99CB0c968810d4E3Af0b7");
  const claimContract = await igo.claimContract();
  console.log("Claim address: ", claimContract);

  const Claim = await ethers.getContractFactory("IGOClaim");
  const claim = Claim.attach(claimContract);
  const allocTime = await claim.allocationTime();
  console.log("Allocation time: ", allocTime);
  const publicTime = await claim.publicTime();
  console.log("Public time: ", publicTime);
  const percentage = await claim.claimPercentage();
  console.log("Percentage unlocked: ", percentage);
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
