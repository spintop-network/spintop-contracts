const hardhat = require("hardhat");
const {
  TESTNET_SPIN_ADDRESS,
  BINANCE_PEGGED_USDT,
} = require("../../constants");
const { ethers, upgrades } = hardhat;

async function main() {
  const isBscTestnet = hardhat.network.name === "bsctestnet";
  const owner = new ethers.Wallet(hardhat.network.config.accounts[0]).address;
  const merkledIGOClaimContract =
    await ethers.getContractFactory("MerkledIGOClaim");

  const merkleRoot =
    "0xee27fdc96653ec1ef81fc3375e1367d7a3109178630a9515db2c548006a0ae89";
  const paymentToken = isBscTestnet
    ? TESTNET_SPIN_ADDRESS
    : BINANCE_PEGGED_USDT;
  const token = isBscTestnet ? TESTNET_SPIN_ADDRESS : BINANCE_PEGGED_USDT;
  const price = 5;
  const priceDecimal = 2;
  const tokenDecimal = 18;
  const claimPercentage = 10;
  const isLinear = true;
  const refundPeriodStart = Math.floor(Date.now() / 1000);
  const refundPeriodEnd = Math.floor(Date.now() / 1000) + 60 * 60 * 24 * 3;

  const merkledIGOClaim = await upgrades.deployProxy(merkledIGOClaimContract, [
    merkleRoot,
    price,
    paymentToken,
    owner,
    priceDecimal,
    isLinear,
    token,
    tokenDecimal,
    claimPercentage,
    refundPeriodStart,
    refundPeriodEnd,
  ]);

  await merkledIGOClaim.waitForDeployment();

  // await (await merkledIGOClaim.setToken(token, tokenDecimal)).wait();
  // await (await merkledIGOClaim.notifyVesting(claimPercentage)).wait();
  // await (
  //   await merkledIGOClaim.setRefundPeriod(refundPeriodStart, refundPeriodEnd)
  // ).wait();

  console.log("MerkledIGOClaim deployed: ", await merkledIGOClaim.getAddress());
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
