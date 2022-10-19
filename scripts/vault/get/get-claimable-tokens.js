const { ethers } = require("hardhat");

async function main() {
  const Vault = await ethers.getContractFactory("IGOVault");
  const vault = Vault.attach("0x03447d28FC19cD3f3cB449AfFE6B3725b3BCdA77");
  const igoAddress = await vault.IGOs(0);

  console.log("IGO contract: ", igoAddress);

  const IGO = await ethers.getContractFactory("IGO");
  const igo = IGO.attach(igoAddress);
  const claimContract = await igo.claimContract();
  console.log("Claim address: ", claimContract);

  const Claim = await ethers.getContractFactory("IGOClaim");
  const claim = Claim.attach(claimContract);

  const claimable = parseFloat(
    ethers.utils.formatEther(
      await claim.claimableTokens("0xC370b50eC6101781ed1f1690A00BF91cd27D77c4")
    )
  );
  console.log("Claimable: ", claimable);
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
