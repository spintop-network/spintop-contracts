async function main() {
  const SpinVault = await ethers.getContractFactory("IGOVault");
  const spinVault = SpinVault.attach(
    "0xB2EfBa3fcABec8898416922C7510CD620a92003b"
  );
  await spinVault.deposit(ethers.utils.parseEther("1000"), {gasLimit: 80000000,
    gasPrice: 7000000000,});
  console.log("Staked");
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
