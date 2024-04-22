const { ethers } = require("hardhat");
const { writeFile } = require("fs").promises;

async function main() {
  const userPaidEventHash =
    "0x188c4d19b4fadd1889d9bd9bf0ab7c97e0719434751e6c05feac6339c1c001ec";
  const userPaidPublicEventHash =
    "0xe8f6864160c28ae0156d5a613860d50b6321685091569283c9ab980401b4ab81";
  const igoClaimContractAddress = "0xDdce4D9d24a226f4f2867f1E29715aA22380C7Cc";

  const provider = new ethers.JsonRpcProvider(
    "https://bsc-mainnet.nodereal.io/v1/f95f3a4751cb4b81a5c2ea4ee81afd4c",
  );
  const currentBlockNumber = await provider.getBlockNumber();
  console.log(currentBlockNumber);

  const events = [];
  let fromBlock = 37883111;
  while (true) {
    try {
      const toBlock =
        fromBlock + 49999 > currentBlockNumber
          ? currentBlockNumber
          : fromBlock + 49999;

      for await (const eventHash of [
        userPaidEventHash,
        userPaidPublicEventHash,
      ]) {
        const response = await fetch(
          "https://bsc-mainnet.nodereal.io/v1/f95f3a4751cb4b81a5c2ea4ee81afd4c",
          {
            method: "POST",
            headers: {
              "Content-Type": "application/json",
            },
            body: JSON.stringify({
              id: 1,
              jsonrpc: "2.0",
              method: "eth_getLogs",
              params: [
                {
                  fromBlock: `0x${fromBlock.toString(16)}`,
                  toBlock: `0x${toBlock.toString(16)}`,
                  address: [igoClaimContractAddress],
                  topics: [eventHash],
                },
              ],
            }),
          },
        );

        const data = await response.json();
        console.log(
          data.result.length,
          fromBlock,
          currentBlockNumber - fromBlock,
        );
        events.push(...data.result);
      }

      await new Promise((resolve) => setTimeout(resolve, 250));

      if (toBlock >= currentBlockNumber) {
        console.log("No more events", events.length);
        break;
      }

      fromBlock += 50000;
    } catch (e) {
      console.error(e);
      break;
    }
  }

  const userMappedPaidAmounts = {};
  const userAllocationRoundOnly = {};
  const userPublicRoundOnly = {};

  for (const event of events) {
    const wallet = `0x${event.topics[1].slice(26)}`;
    if (userMappedPaidAmounts[wallet] === undefined) {
      userMappedPaidAmounts[wallet] = BigInt(0);
    }
    if (event.topics[0] === userPaidEventHash) {
      userAllocationRoundOnly[wallet] =
        userAllocationRoundOnly[wallet] === undefined
          ? BigInt(event.data)
          : userAllocationRoundOnly[wallet] + BigInt(event.data);
    } else if (event.topics[0] === userPaidPublicEventHash) {
      userPublicRoundOnly[wallet] =
        userPublicRoundOnly[wallet] === undefined
          ? BigInt(event.data)
          : userPublicRoundOnly[wallet] + BigInt(event.data);
    }
    userMappedPaidAmounts[wallet] += BigInt(event.data);
  }

  const totalPaidAmount = Object.values(userMappedPaidAmounts).reduce(
    (acc, amount) => acc + amount,
    BigInt(0),
  );

  console.log("Total paid amount: ", totalPaidAmount);

  await writeFile(
    `${igoClaimContractAddress.slice(0, 8)}-events.json`,
    JSON.stringify(events, null, 2),
    "utf-8",
  );
  await writeFile(
    `${igoClaimContractAddress.slice(0, 8)}-amounts-merged.json`,
    JSON.stringify(
      Object.entries(userMappedPaidAmounts).map(([wallet, amount]) => [
        wallet,
        amount.toString(),
      ]),
      null,
      2,
    ),
    "utf-8",
  );
  await writeFile(
    `${igoClaimContractAddress.slice(0, 8)}-amounts-separated.json`,
    JSON.stringify(
      Object.entries(userMappedPaidAmounts).map(([wallet, amount]) => [
        wallet,
        ethers.formatEther(amount.toString()),
        userAllocationRoundOnly[wallet]
          ? ethers.formatEther(userAllocationRoundOnly[wallet].toString())
          : "0",
        userPublicRoundOnly[wallet]
          ? ethers.formatEther(userPublicRoundOnly[wallet].toString())
          : "0",
      ]),
      null,
      2,
    ),
    "utf-8",
  );
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
