async function main() {
  const SpinVault = await ethers.getContractFactory("IGOVault");
  const spinVault = SpinVault.attach(
    "0x03447d28FC19cD3f3cB449AfFE6B3725b3BCdA77"
  );

  const igoId = 0; // Unique IGO id
  const gameToken = "0x00f80a8f39bb4D04a3038C497E3642bf1B0A304e";
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
