async function main() {
  const SwapRouter = await ethers.getContractFactory("SwapRouter");
  const swapRouter = await SwapRouter.deploy(
    "0x6131B5fae19EA4f9D964eAc0408E4408b66337b5",
    "0x97A4be8F51fa04368d8eE2128d62C51fBaDA44EF",
    10,
    "0x97A4be8F51fa04368d8eE2128d62C51fBaDA44EF",
  );
  await swapRouter.waitForDeployment();

  console.log("SwapRouter: ", await swapRouter.getAddress());
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
