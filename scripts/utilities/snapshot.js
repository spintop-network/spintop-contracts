const { ethers } = require("hardhat");

async function main() {
  const ookengaClaim = "0x13B87a0081953BebEDaAadECD9ca8bCe2d029039";
  const IGOClaim = await ethers.getContractFactory("IGOClaim");
  const igoClaim = IGOClaim.attach(ookengaClaim);
  const endBlock = await ethers.provider.getBlockNumber();
  const startBlock = 21292600;
  let allEvents = [];

  for (let i = startBlock; i < endBlock; i += 5000) {
    const _startBlock = i;
    const _endBlock = Math.min(endBlock, i + 4999);
    const events = await igoClaim.queryFilter("UserPaid", _startBlock, _endBlock);
    allEvents = [...allEvents, ...events];
  }

  let allTuples = [];
  let totalAmount = 0;
  let buyers = allEvents.map((event) => event.args[0]);
  let amounts = allEvents.map((event) => parseFloat(ethers.utils.formatEther(event.args[1])));

  // const set = new Set();
  // const unq_buyers = buyers.filter((buyer, i) => {
  //   if (set.has(buyer)) {
  //     return false;
  //   } else {
  //     set.add(buyer);
  //     return true;
  //   }
  // });

  let counter = 0;
  for (let i = 0; i < buyers.length; i++) {
    let existsAt = -1;
    for (let j = 0; j < counter; j++) {
      if (allTuples[j][0] == buyers[i]) {
        existsAt = j;
        allTuples[j][1] += amounts[i] * 0.7083;
        break;
      }
    }
    if (existsAt == -1) {
      allTuples[counter] = [buyers[i], amounts[i] * 0.7083];
      counter++;
    }
    totalAmount += amounts[i] * 0.7083;
  }

  console.log("Total users -> ", buyers.length);
  console.log("Total amount -> ", totalAmount);
  console.log("Total unique entries -> ", allTuples.length);

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
