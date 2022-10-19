const { ethers } = require("hardhat");

async function main() {
  const SpinVault = await ethers.getContractFactory("IGOVault");
  const spinVault = SpinVault.attach(
    "0xAdea083E4c3dD1f1EDF3206479378D8894B1ca66"
  );
  const Mock20 = await ethers.getContractFactory("ERC20Mock");
  const mock20 = Mock20.attach("0x37d949ee361f953De5399410910aC76c96E2b279");

  const igoId = 4;
  const igoAddress = await spinVault.IGOs(igoId);

  const IGO = await ethers.getContractFactory("IGO");
  const igo = IGO.attach(igoAddress);
  const igoClaimAddress = await igo.claimContract();

  const tokenTx = await mock20.transfer(
    igoClaimAddress,
    ethers.utils.parseEther("3750000")
  );
  await tokenTx.wait();
  console.log("Sent tokens.");
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
