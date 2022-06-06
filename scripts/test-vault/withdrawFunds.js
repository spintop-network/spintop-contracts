async function main() {
  const SpinVault = await ethers.getContractFactory("IGOVault");
  const spinVault = SpinVault.attach(
    "0xAdea083E4c3dD1f1EDF3206479378D8894B1ca66"
  );

  const igoId = 4; // Unique IGO id

  const igoAddress = await spinVault.IGOs(igoId);
  // const cmdWithdrawFunds = await spinVault.withdrawIGOFunds(igoAddress, 0); // Pull all dollars
  // await cmdWithdrawFunds.wait();
  // console.log("Dollars are home.");
  const cmdWithdrawFunds2 = await spinVault.withdrawIGOFunds(igoAddress, 1); // Pull all tokens
  await cmdWithdrawFunds2.wait();
  console.log("Tokens are home.");
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
