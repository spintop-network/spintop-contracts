async function main() {
  const SpinVault = await ethers.getContractFactory("IGOVault");
  const spinVault = SpinVault.attach("0x7585C090C772A7bd5dAcAe3495BE615BcA868002");

  const igoId = 9; // Unique IGO id
  const gameToken = "0x8d008B313C1d6C7fE2982F62d32Da7507cF43551";
  const gameDecimal = 18;

  const igoAddress = await spinVault.IGOs(igoId);
  const cmdSetToken = await spinVault.setToken(igoAddress, gameToken, gameDecimal);
  await cmdSetToken.wait();
  console.log("Set token.");
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
