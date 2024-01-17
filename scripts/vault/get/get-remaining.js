const given = require("../../trivians/frmt.json");
const deserved = require("./adjusted_trivians.json");
const { ethers } = require("ethers");
const { MerkleTree } = require("merkletreejs");
const { solidityKeccak256 } = require("ethers/lib/utils");
const keccak256 = require("keccak256");

const claimContract = "0x0ca4d43fa7a5032a0cee1f9cbdf717dbb614df05";
async function main() {
  let final = [];
  for (let i = 0; i < given.result.length; i++) {
    final = given.result.filter(
      (item) => "0x" + item.topics[1].substring(26, 66) == claimContract,
    );
  }
  const amounts = final.map((item) => {
    return parseInt(item.data, 16);
  });
  const claimers = final.map((item) => {
    return "0x" + item.topics[2].substring(26, 66);
  });
  let claimed = [];
  let realClaimers = [];
  let diff = 0;
  for (let i = 0; i < amounts.length; i++) {
    let realFirstIndex = realClaimers.indexOf(claimers[i]);
    if (realFirstIndex != -1) {
      claimed[realFirstIndex][1] += amounts[i];
      diff++;
    } else {
      let realIndex = i - diff;
      claimed[realIndex] = [claimers[i], amounts[i]];
      realClaimers[realIndex] = ethers.utils.hexlify(claimers[i]);
    }
  }
  let toGive = [];
  for (let i = 0; i < deserved.length; i++) {
    let index = realClaimers.indexOf(ethers.utils.hexlify(deserved[i][0]));
    let amount = index == -1 ? 0 : claimed[index][1];
    toGive[i] = [
      ethers.utils.hexlify(deserved[i][0]),
      deserved[i][1] * 1000 - amount,
    ];
  }

  const fs = require("fs");
  const data = JSON.stringify(toGive);
  fs.writeFileSync("./remainingTrivia.json", data, "utf8", (err) => {
    if (err) {
      console.log(`Error writing file: ${err}`);
    } else {
      console.log(`File is written successfully!`);
    }
  });
  let merkleTree, leafNodes, rootHash;

  // merkle
  leafNodes = toGive.map((item) => {
    return solidityKeccak256(["address", "uint256"], [item[0], item[1]]);
  });
  merkleTree = new MerkleTree(leafNodes, keccak256, {
    sortPairs: true,
  });
  rootHash = merkleTree.getHexRoot();
  console.log("Root: ", rootHash);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
