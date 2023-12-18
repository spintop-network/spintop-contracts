//deploy IGOLinearVesing.sol

// bytes32 root,
// address tokenAddress,
// uint256 tokenAmount,
// uint256 totalDollars,
// uint256 firstClaimTime,
// uint256 duration,
// uint256 percentageUnlocked,
// uint256 refundPeriodStart,
// uint256 refundPeriodEnd,
// address InitialOwner

async function main() {

      const merkleRoot = "0xeec53bc20e89781ca468b8b65c2de2df5055afd22e601a04bf5ec9a9744bb2c3";
      const tokenAddress = "0x6c96d72b04EA665bA7147C997457D07beC973593";
      const vestingDuration = 100000;
      const vestingCliff = 300;
      const percentageUnlocked = 10;
      const totalDollars = 10000;
      const firstClaimTime = (1702642562);
      const refundPeriodStart = (1702642562);
      const refundPeriodEnd = (1702642562); 
      const ownerAddress = "0xf7e564B02e449099758Ee2EB4253ef9a5Ba4Fc9b";


    //convert totalAmount to bigint
    const totalAmount = BigInt(1000000000000000000000);
    const IGOLinearVesting = await ethers.getContractFactory("IGOLinearVesting");
    const igoLinearVesting = await IGOLinearVesting.deploy(merkleRoot, tokenAddress,totalAmount, totalDollars, firstClaimTime, vestingDuration, percentageUnlocked, refundPeriodStart, refundPeriodEnd, ownerAddress );
    await igoLinearVesting.deployed();  
    
    console.log("IGOLinearVesting deployed: ", igoLinearVesting.address);
    }
    main()
    .then(() => process.exit(0))
    .catch((error) => {
    console.error(error);
    process.exit(1);
    }
    );

