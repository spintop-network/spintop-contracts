async function main() {
  const SpinVault = await ethers.getContractFactory("IGOVault");
  const spinVault = SpinVault.attach("0xF4A2e75619985CA21860970279E2D608493032d5");

  const igoId = 45; // Unique IGO id
  const gameToken = "0x6c96d72b04EA665bA7147C997457D07beC973593";
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
