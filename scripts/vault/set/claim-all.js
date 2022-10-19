const { ethers } = require("hardhat");

async function main() {
  const SpinVault = await ethers.getContractFactory("IGOVault");
  const spinVault = SpinVault.attach(
    "0xAdea083E4c3dD1f1EDF3206479378D8894B1ca66"
  );

  const igoId = 4; // Unique IGO id
  const igoAddress = await spinVault.IGOs(igoId);
  const IGO = await ethers.getContractFactory("IGO");
  const igo = IGO.attach(igoAddress);
  const igoClaimAddress = await igo.claimContract();
  console.log(igoClaimAddress);
  const IGOClaim = await ethers.getContractFactory("IGOClaim");
  const igoClaim = IGOClaim.attach(igoClaimAddress);

  const tx = await igoClaim.claimTokens();
  await tx.wait();
  console.log(tx);
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
