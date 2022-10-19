async function main() {
  const SpinVault = await ethers.getContractFactory("IGOVault");
  const spinVault = SpinVault.attach("0x03447d28FC19cD3f3cB449AfFE6B3725b3BCdA77");

  const igoId = 5; // Unique IGO id
  const igoAddress = await spinVault.IGOs(igoId);

  const cmdWithdrawFunds = await spinVault.withdrawIGOFunds(igoAddress, 0); // Pull all dollars
  await cmdWithdrawFunds.wait();
  console.log("Dollars are home.");
  // const cmdWithdrawFunds2 = await spinVault.withdrawIGOFunds(igoAddress, 1); // Pull all tokens
  // await cmdWithdrawFunds2.wait();
  // console.log("Tokens are home.");
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
