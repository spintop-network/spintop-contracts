async function main() {
  const spinToken = "";
  const spinPool = "";
  const SpinVault = await ethers.getContractFactory("IGOVault");
  const spinVault = SpinVault.attach("");

  await spinVault.pause();
  await spinVault.createIGO(
    "Spinstarter King",
    ethers.utils.parseEther("200000"),
    spinToken,
    "1",
    "18000",
    "1"
  );
  const members = await spinVault.membersLength();
  const batchCount = Math.floor(members / 500) + 1;
  for (let i = 0; i < batchCount; i++) {
    await spinVault.migrateBalances();
  }
  await spinVault.start();
  await spinVault.unpause();
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
