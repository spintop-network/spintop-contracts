//deploy IGOLinearVesing.sol

async function main() {

      const merkleRoot = "0xeec53bc20e89781ca468b8b65c2de2df5055afd22e601a04bf5ec9a9744bb2c3";
      const tokenAddress = "0x6c96d72b04EA665bA7147C997457D07beC973593";
        const vestingDuration = 600;
        const vestingCliff = 10;

    //convert totalAmount to bigint
    const totalAmount = BigInt(1000000000000000000000);
    const IGOLinearVesting = await ethers.getContractFactory("IGOLinearVesting");
    const igoLinearVesting = await IGOLinearVesting.deploy(merkleRoot, tokenAddress, totalAmount, vestingDuration, vestingCliff);
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

