async function main() {
  const IGO = await ethers.getContractFactory("IGO");
  const igo = IGO.attach("0xa524A542E43CAD73d9ac25d6bF908FCB95138434");
  const cmdClaim2 = await igo.earned(
    "0x3f2f1Ee44F06D1054C7F94FeDd250009AB013206",
  );
  console.log("claimableTokens", cmdClaim2);
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
