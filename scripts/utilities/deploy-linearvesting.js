const hardhat = require("hardhat");

async function main() {
  const now = new Date();

  const merkleRoot =
    "0x3049c77bf574935c55ca5069f95cf5eeee93ad61846c1e2abd59c27cacf78f5d";
  const tokenAddress = "0x6c96d72b04EA665bA7147C997457D07beC973593";
  const vestingDuration = 100000;
  const percentageUnlocked = 10;
  const firstClaimTime = Math.floor(now.getTime() / 1000); // now
  const refundPeriodStart = Math.floor(now.getTime() / 1000); // now
  const refundPeriodEnd = Math.floor((now.getTime() + 1000 * 300) / 1000); // 30 minutes from now
  const ownerAddress = "0xF04a7d27F93f48B69e5C846097D21F52806BC135";

  if (refundPeriodStart >= refundPeriodEnd) {
    throw new Error("refundPeriodStart must be less than refundPeriodEnd");
  }
  if (percentageUnlocked > 100) {
    throw new Error("percentageUnlocked should not be greater than 100.");
  }

  //convert totalAmount to bigint
  const totalAmount = 100_000_000_000_000_000_000_000n;
  const IGOLinearVesting = await ethers.getContractFactory("IGOLinearVesting");
  const igoLinearVesting = await IGOLinearVesting.deploy(
    merkleRoot,
    tokenAddress,
    totalAmount,
    firstClaimTime,
    vestingDuration,
    percentageUnlocked,
    refundPeriodStart,
    refundPeriodEnd,
    ownerAddress,
  );
  await igoLinearVesting.waitForDeployment();
  console.log("IGOLinearVesting deployed to:", igoLinearVesting.target);
  console.log("Parameters", {
    merkleRoot,
    tokenAddress,
    totalAmount,
    firstClaimTime,
    vestingDuration,
    percentageUnlocked,
    refundPeriodStart,
    refundPeriodEnd,
    ownerAddress,
  });
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
