const { ethers } = require("hardhat");

async function main() {
  const SpinVault = await ethers.getContractFactory("IGOVault");
  const spinVault = SpinVault.attach(
    "0x03447d28FC19cD3f3cB449AfFE6B3725b3BCdA77"
  );
  const GameToken = await ethers.getContractFactory("ERC20Mock");
  const gameToken = GameToken.attach(
    "0x00f80a8f39bb4D04a3038C497E3642bf1B0A304e"
  );

  const igoId = 0;
  const igoAddress = await spinVault.IGOs(igoId);

  const IGO = await ethers.getContractFactory("IGO");
  const igo = IGO.attach(igoAddress);
  const igoClaimAddress = await igo.claimContract();

  const tokenTx = await gameToken.transfer(
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
