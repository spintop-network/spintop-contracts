async function main() {
  const SpinVault = await ethers.getContractFactory("IGOVault");
  const spinVault = SpinVault.attach(
    "0x03447d28FC19cD3f3cB449AfFE6B3725b3BCdA77",
  );

  const members = await spinVault.membersLength();
  console.log("Members: ", members);
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
