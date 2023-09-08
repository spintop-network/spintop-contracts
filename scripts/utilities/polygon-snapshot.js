const { ethers } = require("hardhat");
async function main() {
  // const farm_address = "0x25ab8675C57B4A6Da14677e1353bC59d613F69b5";
  const farm_address = "0x4Fc1F5EF6886a446637FFfF76F8C4D79EDF395CF"; // pool
  const Farm = await ethers.getContractFactory("SpinStakable");
  const farm = Farm.attach(farm_address);
  const endBlock = await ethers.provider.getBlockNumber();
  const startBlock = 27404282;
  let allEvents = [];
  for (let i = startBlock; i < endBlock; i += 50000) {
    const _startBlock = i;
    const _endBlock = Math.min(endBlock, i + 49999);
    const events = await farm.queryFilter("Staked", _startBlock, _endBlock);
    allEvents = [...allEvents, ...events];
  }
  console.log(allEvents.length);
  let buyers = allEvents.map((event) => event.args[0]);
  buyers = [...new Set(buyers)];
  let balances = [];
  for (let i = 0; i < buyers.length; i++) {
    balances[i] = parseFloat(ethers.utils.formatEther(await farm.balanceOf(buyers[i])));
  }
  let tuples = [];
  for (let i = 0; i < buyers.length; i++) {
    tuples[i] = [buyers[i], (balances[i])];
  }
  tuples = tuples.filter((tuple) => tuple[1] > 0);
  const fs = require("fs");
  const data = JSON.stringify(tuples);
  const arrayToCSV = (arr, delimiter = ',') =>
    arr
      .map(v =>
        v.map(x => (isNaN(x) ? `"${x.replace(/"/g, '""')}"` : x)).join(delimiter)
      )
      .join('\n');
  const csv = arrayToCSV(tuples);
  fs.writeFileSync("./polygon-pool-snapshot.csv", csv, "utf8", (err) => {
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
