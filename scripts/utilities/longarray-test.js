async function main() {
  const LongArray = await ethers.getContractFactory("LongArray");
  const longArray = await LongArray.deploy();
  await longArray.waitForDeployment();

  console.log("LongArray deployed: ", longArray.target);

  let array = await longArray.getArray();
  console.log("Array: ", array);
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
