const { ethers } = require("hardhat");

async function main() {
  const Vault = await ethers.getContractFactory("IGOVault");
  const vault = Vault.attach("0xAdea083E4c3dD1f1EDF3206479378D8894B1ca66");
  const igoAddress = await vault.IGOs(9);

  console.log("IGO contract: ", igoAddress);

  const IGO = await ethers.getContractFactory("IGO");
  const igo = IGO.attach(igoAddress);
  const claimContract = await igo.claimContract();
  console.log("Claim address: ", claimContract);

  // const Claim = await ethers.getContractFactory("IGOClaim");
  // const claim = Claim.attach(claimContract);
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
