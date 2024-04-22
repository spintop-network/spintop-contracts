const { ethers } = require("hardhat");
const { writeFile } = require("fs").promises;

async function main() {
  const userPaidEventHash =
    "0x188c4d19b4fadd1889d9bd9bf0ab7c97e0719434751e6c05feac6339c1c001ec";
  const userPaidPublicEventHash =
    "0xe8f6864160c28ae0156d5a613860d50b6321685091569283c9ab980401b4ab81";
  // const igoClaimContractAddress = "0xDdce4D9d24a226f4f2867f1E29715aA22380C7Cc";
  const igoClaimContractAddresses = [
    "0xf22ebcF36d2eB9d32736216Ee70f8c2BA29Cfe15", // SUGAR KINGDOM
    "0xFD4122c5D3c2876a04131F81005b5d323ddB798F", // RGAMES
    "0xDdce4D9d24a226f4f2867f1E29715aA22380C7Cc", // FISHVERSE
  ];
  const JSON_RPC_URL =
    "https://bsc-mainnet.nodereal.io/v1/f95f3a4751cb4b81a5c2ea4ee81afd4c";

  const provider = new ethers.JsonRpcProvider(JSON_RPC_URL);
  const currentBlockNumber = await provider.getBlockNumber();
  console.log(currentBlockNumber);

  const events = {};
  for (const claimContract of igoClaimContractAddresses) {
    let fromBlock = 37104690;
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
          const response = await fetch(JSON_RPC_URL, {
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
                  address: [claimContract],
                  topics: [eventHash],
                },
              ],
            }),
          });

          const data = await response.json();
          console.log(
            data.result.length,
            fromBlock,
            currentBlockNumber - fromBlock,
          );
          events[claimContract] = events[claimContract] || [];
          events[claimContract].push(...data.result);
        }

        await new Promise((resolve) => setTimeout(resolve, 250));

        if (toBlock >= currentBlockNumber) {
          // console.log("No more events", events.length);
          break;
        }

        fromBlock += 50000;
      } catch (e) {
        console.error(e);
        break;
      }
    }
  }

  const userDataGroupedByClaimContract = {};

  for (const [claimContract, claimEvents] of Object.entries(events)) {
    const userMappedPaidAmounts = {};
    const userAllocationRoundOnly = {};
    const userPublicRoundOnly = {};

    for (const event of claimEvents) {
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

    userDataGroupedByClaimContract[claimContract] = {
      userMappedPaidAmounts,
      userAllocationRoundOnly,
      userPublicRoundOnly,
      totalPaidAmount,
    };
  }

  const allUsers = Object.values(userDataGroupedByClaimContract).reduce(
    (acc, userData) => {
      for (const wallet of Object.keys(userData.userMappedPaidAmounts)) {
        if (!acc.includes(wallet)) {
          acc.push(wallet);
        }
      }
      return acc;
    },
    [],
  );

  const separatedData = allUsers.map((wallet) => {
    const amounts = [];
    for (const userData of Object.values(userDataGroupedByClaimContract)) {
      amounts.push([
        ethers.formatEther(userData.userMappedPaidAmounts[wallet] || BigInt(0)),
        ethers.formatEther(
          userData.userAllocationRoundOnly[wallet] || BigInt(0),
        ),
        ethers.formatEther(userData.userPublicRoundOnly[wallet] || BigInt(0)),
      ]);
    }
    return [wallet, ...amounts.flat()];
  });
  console.log(separatedData.length);

  await writeFile(
    `igoclaim-amounts-separated.json`,
    JSON.stringify(separatedData, null, 2),
    "utf-8",
  );
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
