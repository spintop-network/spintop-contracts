async function main() {
  const erthaFarm = "0x8216d2Ff8F47083367A44A3584169792b07f97d8";
  const SpinStakable = await ethers.getContractFactory("SpinStakable");
  const spinStakable = await SpinStakable.attach(erthaFarm);
  const provider = new ethers.providers.JsonRpcProvider(
    "https://bsc-dataseed.binance.org/"
  );
  const endBlock = await provider.getBlockNumber();
  const startBlock = 16765424;
  let allEvents = [];

  for (let i = startBlock; i < endBlock; i += 5000) {
    const _startBlock = i;
    const _endBlock = Math.min(endBlock, i + 4999);
    const events = await spinStakable.queryFilter(
      "Staked",
      _startBlock,
      _endBlock
    );
    allEvents = [...allEvents, ...events];
    console.log("Fetching staked events. #", i);
  }

  let buyers = allEvents.map((event) => event.args[0]);
  // console.log(results);

  let allTuples = [];
  for (let i = 0; i < buyers.length; i++) {
    let tokenAmt = parseFloat(
      ethers.utils.formatUnits(await spinStakable.balanceOf(buyers[i]), 6)
    );
    let tuple = [buyers[i], tokenAmt];
    allTuples[i] = tuple;
  }

  const fs = require("fs");
  const data = JSON.stringify(allTuples);
  fs.writeFileSync("./erthaFarmEntries.json", data, "utf8", (err) => {
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
