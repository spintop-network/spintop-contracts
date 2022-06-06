async function main() {
  const SpinVault = await ethers.getContractFactory("IGOVault");
  const spinVault = SpinVault.attach(
    "0xAdea083E4c3dD1f1EDF3206479378D8894B1ca66"
  );

  const igoId = 4; // Unique IGO id
  const gameToken = "0x37d949ee361f953De5399410910aC76c96E2b279";
  const gameDecimal = 18;

  const igoAddress = await spinVault.IGOs(igoId);
  const cmdSetToken = await spinVault.setToken(
    igoAddress,
    gameToken,
    gameDecimal
  );
  await cmdSetToken.wait();
  console.log("Set token.");
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
