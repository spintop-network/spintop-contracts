const { ethers } = require("hardhat");

async function main() {
  const erthaFarm = "0x484c5CEE7C37eF93dC0cAfB19e5D265b582485D6";
  const Farm = await ethers.getContractFactory("MultiStaking");
  const farm = Farm.attach(erthaFarm);
  const endBlock = await ethers.provider.getBlockNumber();

  const startBlock = 22853600;
  let allEvents = [];

  for (let i = startBlock; i < endBlock; i += 5000) {
    const _startBlock = i;
    const _endBlock = Math.min(endBlock, i + 4999);
    const events = await farm.queryFilter("Staked", _startBlock, _endBlock);
    allEvents = [...allEvents, ...events];
    console.log(allEvents);
  }

  let allTuples = [];
  let totalAmount = 0;
  let blocks = allEvents.map((event) => event.blockNumber);
  //   let buyers = allEvents.map((event) => event.args[0]);
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

  //   let counter = 0;
  //   for (let i = 0; i < buyers.length; i++) {
  //     let existsAt = -1;
  //     for (let j = 0; j < counter; j++) {
  //       if (allTuples[j][0] == buyers[i]) {
  //         existsAt = j;
  //         allTuples[j][1] += amounts[i];
  //         break;
  //       }
  //     }
  //     if (existsAt == -1) {
  //       allTuples[counter] = [buyers[i], amounts[i]];
  //       counter++;
  //     }
  //     totalAmount += amounts[i];
  //   }

  //   console.log("Total users -> ", buyers.length);
  //   console.log("Total amount -> ", totalAmount);
  //   console.log("Total unique entries -> ", allTuples.length);

  let counter = 0;
  for (let i = 0; i < blocks.length; i++) {
    let existsAt = -1;
    for (let j = 0; j < counter; j++) {
      if (allTuples[j][0] == blocks[i]) {
        existsAt = j;
        allTuples[j][1] += amounts[i];
        break;
      }
    }
    if (existsAt == -1) {
      allTuples[counter] = [blocks[i], amounts[i]];
      counter++;
    }
    totalAmount += amounts[i];
  }
  console.log("Total amount -> ", totalAmount);

  const fs = require("fs");
  const data = JSON.stringify(allTuples);
  fs.writeFileSync("./ertha-blocks.json", data, "utf8", (err) => {
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
