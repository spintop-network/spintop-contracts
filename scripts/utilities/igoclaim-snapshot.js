const { ethers } = require("hardhat");
const { writeFile } = require("fs").promises;

async function main() {
  const userPaidEventHash =
    "0x188c4d19b4fadd1889d9bd9bf0ab7c97e0719434751e6c05feac6339c1c001ec";
  const userPaidPublicEventHash =
    "0xe8f6864160c28ae0156d5a613860d50b6321685091569283c9ab980401b4ab81";
  const igoClaimContractAddress = "0xFD4122c5D3c2876a04131F81005b5d323ddB798F";

  const provider = new ethers.JsonRpcProvider(
    "https://bsc-mainnet.nodereal.io/v1/f95f3a4751cb4b81a5c2ea4ee81afd4c",
  );
  const currentBlockNumber = await provider.getBlockNumber();
  console.log(currentBlockNumber);

  const events = [];
  let fromBlock = 37505126;
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

  for (const event of events) {
    const wallet = `0x${event.topics[1].slice(26)}`;
    if (userMappedPaidAmounts[wallet] === undefined) {
      userMappedPaidAmounts[wallet] = BigInt(0);
    }
    userMappedPaidAmounts[wallet] += BigInt(event.data);
  }

  const totalPaidAmount = Object.values(userMappedPaidAmounts).reduce(
    (acc, amount) => acc + amount,
    BigInt(0),
  );

  console.log("Total paid amount: ", totalPaidAmount);

  await writeFile("snapshot.json", JSON.stringify(events, null, 2), "utf-8");
  await writeFile(
    "amounts.json",
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
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
