async function main() {
  const IGOClaim = await ethers.getContractFactory("IGOClaim");
  const igoCLaim = IGOClaim.attach(
    "0x86FFb1b149bbe0C2301582FebBA3c7f6A31B90E0",
  );
  const cmdClaim2 = await igoCLaim.claimedTokens(
    "0x3f2f1Ee44F06D1054C7F94FeDd250009AB013206",
  );
  console.log("claimableTokens", cmdClaim2);
  const cmdClaim3 = await igoCLaim.claimedAmounts(
    "0x3f2f1Ee44F06D1054C7F94FeDd250009AB013206",
  );
  console.log("ClaimclaimedAmountsed", cmdClaim3);
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
