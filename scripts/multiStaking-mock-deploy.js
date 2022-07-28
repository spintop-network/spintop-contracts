async function main() {
  // const Mock20 = await ethers.getContractFactory("ERC20Mock");
  // const MockDecimal = await ethers.getContractFactory("ERC20DecimalMock");
  // const reward = await Mock20.deploy("Reward", "R");
  // await reward.deployed();
  // console.log("Spin addr: ", reward.address);
  // const bonus = await MockDecimal.deploy("Bonus", "B");
  // await bonus.deployed();
  // console.log("Samu addr: ", bonus.address);

  const MultiStaking = await ethers.getContractFactory("MultiStaking");
  const multiStaking = await MultiStaking.deploy(
    "0x9dAF91eC9Cc0B6327FFD92BE79716f24619DD142",
    "0x94f3987A5D6770f6177CC21AFff9f806b9E7E34A",
    "0xBfd1975d4a32aE51419c3E4421f2706b11bDe728"
  );
  await multiStaking.deployed();
  console.log("Farm deployed: ", multiStaking.address);
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
