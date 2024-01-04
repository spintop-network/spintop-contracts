async function main() {
  const MultiSend = await ethers.getContractFactory("MultiSendCustom");
  const multiSend = await MultiSend.deploy();
  await multiSend.waitForDeployment();

  console.log("MultiSend deployed: ", multiSend.target);
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
