const { ethers } = require("hardhat");
async function main() {
  const lock_address = "0x2Ea63f003E077616969B59370C0b611a5B993a80";
  const Lock = await ethers.getContractFactory("Lock");
  const lock = Lock.attach(lock_address);
  const endBlock = await ethers.provider.getBlockNumber();
  const startBlock = 46187837;
  let allEvents = [];
  for (let i = startBlock; i < endBlock; i += 50000) {
    const _startBlock = i;
    const _endBlock = Math.min(endBlock, i + 49999);
    const events = await lock.queryFilter("Deposit", _startBlock, _endBlock);
    allEvents = [...allEvents, ...events];
  }
  console.log(allEvents.length);
  let buyers = allEvents.map((event) => event.args[0]);
  let amounts = allEvents.map((event) => parseFloat(ethers.utils.formatEther(event.args[1])));
  let tuples = [];
  let counter = 0;
  for (let i = 0; i < buyers.length; i++) {
    let existsAt = -1;
    for (let j = 0; j < counter; j++) {
      if (tuples[j][0] == buyers[i]) {
        existsAt = j;
        tuples[j][1] += amounts[i];
        break;
      }
    }
    if (existsAt == -1) {
      tuples[counter] = [buyers[i], amounts[i]];
      counter++;
    }
  }
  const fs = require("fs");
  const data = JSON.stringify(tuples);
  fs.writeFileSync("./lock-snapshot-1.json", data, "utf8", (err) => {
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
