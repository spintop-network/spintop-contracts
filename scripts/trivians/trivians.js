const { ethers } = require("hardhat");

async function main() {
  const trivians = "0x1A845f5C863946c335fe46EE7A63e90D8BAa8c22";
  const TargetContract = await ethers.getContractFactory("IGOClaim");
  const targetContract = TargetContract.attach(trivians);
  const provider = new ethers.providers.JsonRpcProvider("https://fragrant-silent-snowflake.bsc.quiknode.pro/1c75461abd6819322507a060e5f05fa910e03446/");
  const endBlock = await provider.getBlockNumber();
  const startBlock = 19300000;
  let allEvents = [];

  for (let i = startBlock; i < endBlock; i += 5000) {
    const _startBlock = i;
    const _endBlock = Math.min(endBlock, i + 4999);
    const events = await targetContract.queryFilter(0x648d3cb1, _startBlock, _endBlock);
    allEvents = [...allEvents, ...events];
    console.log("Fetching 'Pay For Token' events. #", i);
  }
  let buyers = allEvents.map((event) => event.args[0]);
  buyers = buyers.filter((item, index) => buyers.indexOf(item) === index);
  console.log(buyers.length, " buyers.");

  let allTuples = [];
  let totalTokens = 0;
  for (let i = 0; i < buyers.length; i++) {
    let tokenAmt = parseFloat(ethers.utils.formatUnits(await targetContract.claimableTokens(buyers[i]), 0));
    // console.log(buyers[i], " purchased: ", tokenAmt);
    let tuple = [buyers[i], tokenAmt];
    allTuples[i] = tuple;
    totalTokens += tokenAmt;
    console.log("Total tokens: ", totalTokens);
  }

  const fs = require("fs");
  const data = JSON.stringify(allTuples);
  fs.writeFileSync("./scripts/trivians/allocations.json", data, "utf8", (err) => {
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
