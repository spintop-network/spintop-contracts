async function main() {
  const spinFarm = "0x6D28F46E0698a2F217c72fF4e86DBFBAc422B1C4";
  const SpinStakable = await ethers.getContractFactory("SpinStakable");
  const spinStakable = await SpinStakable.attach(spinFarm);
  const provider = new ethers.providers.JsonRpcProvider(
    "https://old-black-mountain.bsc.quiknode.pro/0c559d1dd992fb5e9e2ce82ee14bd0bd8c27dfa7/"
  );
  //14526889
  const endBlock = await provider.getBlockNumber();
  const startBlock = 13792715;
  // const startBlock = 15567717;
  let allEvents = [];

  // for (let i = startBlock; i < endBlock; i += 5000) {
  //   const _startBlock = i;
  //   const _endBlock = Math.min(endBlock, i + 4999);
  //   const events = await spinStakable.queryFilter(
  //     "Staked",
  //     _startBlock,
  //     _endBlock
  //   );
  //   allEvents = [...allEvents, ...events];
  //   console.log("Fetching staked events. #", i);
  // }

  const sfundClaimerAddr = "0xe1195fAA3e0070Cf1444685865e5A0775AD5124c";
  const SfundClaimer = await ethers.getContractFactory("ClaimerMock");
  const sfundClaimer = await SfundClaimer.attach(sfundClaimerAddr);

  for (let i = startBlock; i < endBlock; i += 5000) {
    const _startBlock = i;
    const _endBlock = Math.min(endBlock, i + 4999);
    const events = await sfundClaimer.queryFilter(
      "Claimed",
      _startBlock,
      _endBlock
    );
    allEvents = [...allEvents, ...events];
    console.log("Fetching claimed events. #", i);
  }

  // const balances = {};
  const claimables = {};
  const setBalances = async () => {
    for (let i = 0; i < allEvents.length; i++) {
      const _user = allEvents[i].args.user;
      // const _balance = ethers.utils.formatEther(
      //   await spinStakable.balanceOf(_user)
      // );
      const _earned = ethers.utils.formatEther(
        await spinStakable.earned(_user)
      );
      if (_earned > 0) {
        // balances[_user] = _balance;
        claimables[_user] = _earned;
      }
      console.log("Fetching claimable amounts. #", i);
    }
  };
  await setBalances();

  const fs = require("fs");
  // const data = JSON.stringify(balances);
  // fs.writeFileSync("./spin-bnb-balances.json", data, "utf8", (err) => {
  //   if (err) {
  //     console.log(`Error writing file: ${err}`);
  //   } else {
  //     console.log(`File is written successfully!`);
  //   }
  // });

  const data2 = JSON.stringify(claimables);

  fs.writeFileSync("./spin-bnb-claimables.json", data2, "utf8", (err) => {
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
