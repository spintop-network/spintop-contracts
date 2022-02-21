async function main() {
  const fetch = (...args) =>
    import("node-fetch").then(({ default: fetch }) => fetch(...args));
  // const SpinMock = await ethers.getContractFactory("SpinMock");
  // const spinMock = await SpinMock.deploy("Kodegon", "KDG");
  // await spinMock.deployed();
  // const mockAdress = spinMock.address;
  // console.log("Kodegon deployed: ", mockAdress);

  let startingBlock;

  const spinAotFarm = "0xB15655401E3018B7BF3F8c12BdD24A0936636Bc0";
  const SpinStakable = await ethers.getContractFactory("SpinStakable");
  const spinStakable = await SpinStakable.attach(spinAotFarm);
  const provider = new ethers.providers.JsonRpcProvider(
    "https://old-black-mountain.bsc.quiknode.pro/0c559d1dd992fb5e9e2ce82ee14bd0bd8c27dfa7/"
  );
  //14526889
  const endBlock = await provider.getBlockNumber();
  const startBlock = 14526889;
  let allEvents = [];

  let counter = 0;

  for (let i = startBlock; i < endBlock; i += 5000) {
    const _startBlock = i;
    const _endBlock = Math.min(endBlock, i + 4999);
    const events = await spinStakable.queryFilter(
      "Staked",
      _startBlock,
      _endBlock
    );
    allEvents = [...allEvents, ...events];
    // console.log("Round ", counter);
    // console.log("Stake count ", allEvents.length);
    counter++;
  }
  console.log("Length: ", allEvents.length);
  //   console.log("User: ", randomUser);
  //   console.log("LP Balance: ", balance);

  const balances = {};

  const setBalances = async () => {
    for (let i = 0; i < allEvents.length; i++) {
      const _user = allEvents[i].args.user;
      const _balance = ethers.utils.formatEther(
        await spinStakable.balanceOf(_user)
      );

      if (_balance > 0) {
        balances[_user] = _balance;
      }
    }
  };

  await setBalances();

  //   console.log(balances);

  const fs = require("fs");
  const data = JSON.stringify(balances);
  console.log(data);
  fs.writeFileSync("./user.json", data, "utf8", (err) => {
    if (err) {
      console.log(`Error writing file: ${err}`);
    } else {
      console.log(`File is written successfully!`);
    }
  });
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
