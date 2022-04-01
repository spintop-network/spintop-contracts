async function main() {
  const SpinVault = await ethers.getContractFactory("IGOVault");
  const spinVault = SpinVault.attach(
    "0xe7C798a911829323B84E29B9e0a450591578BA26"
  );
  const fakeBUSD = "0xB52A0C6F85563Ee635Dc897d74D9DbBAEf140F3a";

  await spinVault.pause();
  await spinVault.createIGO(
    "Test IGO",
    ethers.utils.parseEther("20000"),
    fakeBUSD,
    "1",
    "1200",
    "2"
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
