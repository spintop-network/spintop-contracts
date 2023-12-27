const hardhat = require("hardhat");

async function main() {
  const ookengaClaim = "0x84494b566f09eB149A381FB3Aab32B28370734D5";
  const IGOClaim = await ethers.getContractFactory("IGOClaim");
  const igoClaim = IGOClaim.attach(ookengaClaim);
  const provider = await new ethers.JsonRpcProvider(hardhat.network.config.url);
  const endBlock = await provider.getBlockNumber();
  const startBlock = 34552935;
  let allEvents = [];

  for (let i = startBlock; i < endBlock; i += 5000) {
    const _startBlock = i;
    const _endBlock = Math.min(endBlock, i + 5000);
    const events = await igoClaim.queryFilter("UserPaid", _startBlock, _endBlock);
    console.log(events.length);
    allEvents = [...allEvents, ...events];
  }

  let allTuples = [];
  let totalAmount = BigInt(0);
  let buyers = allEvents.map((event) => event.args[0]);
  let amounts = allEvents.map((event) => BigInt((event.args[1]).toString()));

  console.log(amounts[0], typeof amounts[0])
  // const UNKNOWN_MULTIPLIER = 0.7083; Is this token price?
  const UNKNOWN_MULTIPLIER = BigInt(100);

  let counter = 0;
  for (let i = 0; i < buyers.length; i++) {
    let existsAt = -1;
    for (let j = 0; j < counter; j++) {
      if (allTuples[j][0] === buyers[i]) {
        existsAt = j;
        allTuples[j][1] += amounts[i] * UNKNOWN_MULTIPLIER;
        break;
      }
    }
    if (existsAt === -1) {
      allTuples[counter] = [buyers[i], amounts[i] * UNKNOWN_MULTIPLIER];
      counter++;
    }
    totalAmount += amounts[i] * UNKNOWN_MULTIPLIER;
  }

  console.log("Total users -> ", buyers.length);
  console.log("Total amount -> ", totalAmount);
  console.log("Total unique entries -> ", allTuples.length);

  allTuples = allTuples.map((tuple) => ([tuple[0], tuple[1].toString()]));
  const fs = require("fs");
  const data = JSON.stringify(allTuples);
  fs.writeFileSync("./ookenga-unq-amounts.json", data, "utf8", (err) => {
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
