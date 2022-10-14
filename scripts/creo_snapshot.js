const { ethers } = require("hardhat");

async function main() {
  const creo = "0x13B87a0081953BebEDaAadECD9ca8bCe2d029039";
  const TargetContract = await ethers.getContractFactory("IGOClaim");
  const targetContract = TargetContract.attach(creo);
  const provider = new ethers.providers.JsonRpcProvider("https://skilled-patient-butterfly.bsc.quiknode.pro/89efe93217115973b4681365c2e7a1e2abc0c29b/");
  const endBlock = await provider.getBlockNumber();
  const startBlock = 21292615;
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

  let allTuples = [];
  let totalTokens = 0;
  for (let i = 0; i < buyers.length; i++) {
    let tokenAmt = parseFloat(ethers.utils.formatUnits(await targetContract.claimableTokens(buyers[i]), 0));
    let tuple = [buyers[i], tokenAmt];
    allTuples[i] = tuple;
    totalTokens += tokenAmt;
  }

  const fs = require("fs");
  const data = JSON.stringify(allTuples);
  fs.writeFileSync("./creoAllocations.json", data, "utf8", (err) => {
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
