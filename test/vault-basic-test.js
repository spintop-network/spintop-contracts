const { ethers } = require("hardhat");

describe("Spinstarter Basic Functionality Test", function () {
  it("Should distribute rewards linearly to 96 stakers.", async function () {
    const poolAddress = "0x06F2bA50843e2D26D8FD3184eAADad404B0F1A67";
    const spinAddress = "0x6AA217312960A21aDbde1478DC8cBCf828110A67";
    const busd = "0xe9e7CEA3DedcA5984780Bafc599bD69ADd087D56";
    const date = parseInt(Date.now() / 1000);

    const DEPLOYER = "0x187549F02D96d94945f2c4Dd206cF58AEed8EBAE";
    await hre.network.provider.request({
      method: "hardhat_impersonateAccount",
      params: [DEPLOYER],
    });
    await network.provider.send("hardhat_setBalance", [
      DEPLOYER,
      "0xfffffffffffffffffffffffffff",
    ]);
    const signer = await ethers.getSigner(DEPLOYER);

    const SpinVaultContract = await ethers.getContractFactory("IGOVault");
    const SpinVault = SpinVaultContract.connect(signer);
    const spinVault = await SpinVault.deploy(
      "Spinstarter Shares",
      "SSS",
      poolAddress,
      spinAddress
    );
    await spinVault.deployed();
    console.log("SpinVault deployed: ", spinVault.address);

    const ERC20Contract = await ethers.getContractFactory("ERC20");
    const ERC20 = ERC20Contract.connect(signer);
    const spinToken = ERC20.attach(spinAddress);
    await spinToken.approve(spinVault.address, ethers.constants.MaxUint256);
    const spinBalance = await spinToken.balanceOf(DEPLOYER);
    console.log("Spin balance check: ", spinBalance);

    await spinVault.deposit(ethers.utils.parseEther("1000"));
    const balance = await spinVault.balance();
    console.log("Total SPIN in vault: ", balance);
    const userBalance = await spinVault.balanceOf(DEPLOYER);
    console.log("User shares: ", userBalance);

    const totalDollars = ethers.utils.parseEther("200000");
    await spinVault.createIGO("Spinstarter King", date, totalDollars, busd);
    const igo = await spinVault.getIGO(0);
    console.log("First IGO's address: ", igo);

    // for (let i = 0; i < 5; i++) {
    //   const [owner, addr1, addr2] = await ethers.getSigners();
    //   let wallet = new ethers.Wallet.createRandom();
    //   wallet = wallet.connect(ethers.getDefaultProvider());
    //   //
    //   // ethers.providers.Provider;

    //   let walletAddress = await wallet.getAddress();

    //   // await network.provider.send("hardhat_setBalance", [
    //   //   walletAddress,
    //   //   "0x3635c9adc5dea00000",
    //   // ]);
    //   // await network.provider.send("evm_mine");

    //   const tx = {
    //     to: walletAddress,
    //     value: ethers.utils.parseEther("0.1"),
    //   };

    //   await signer.sendTransaction(tx);

    //   console.log(await wallet.getBalance());
    //   console.log("Wallet address: ", walletAddress);
    //   await spinToken.transfer(walletAddress, ethers.utils.parseEther("1000"));
    //   console.log("Transferred some SPIN to it.");
    //   await spinToken
    //     .connect(wallet)
    //     .approve(spinVault.address, ethers.constants.MaxUint256);
    //   await spinVault.connect(wallet).deposit(ethers.utils.parseEther("1000"));
    //   console.log("User ", i, " staked 1000 SPIN.");
    // }

    const IgoContract = await ethers.getContractFactory("IGO");
    const IgoSigner = IgoContract.connect(signer);
    const igo_ = IgoSigner.attach(igo);
    await igo_.start();
    const reward1 = await igo_.earned(DEPLOYER);
    console.log("Reward#1: ", reward1);

    await network.provider.send("evm_increaseTime", [300]);
    await network.provider.send("evm_mine");
    const reward2 = await igo_.earned(DEPLOYER);
    console.log("Reward#2: ", reward2);

    await network.provider.send("evm_increaseTime", [300]);
    await network.provider.send("evm_mine");
    await spinVault.deposit(ethers.utils.parseEther("1000"));
    await network.provider.send("evm_increaseTime", [300]);
    await network.provider.send("evm_mine");
    const reward3 = await igo_.earned(DEPLOYER);
    console.log("Reward#3: ", reward3);

    // await spinVault.deposit(ethers.utils.parseEther("1000"));
    // await network.provider.send("evm_increaseTime", [300]);
    // await network.provider.send("evm_mine");
    // const reward4 = await igo_.earned(DEPLOYER);
    // console.log("Reward#4: ", reward4);

    // const igoClaimAddr = await igo_.claimContract();
    // const IgoClaimContract = await ethers.getContractFactory("IGOClaim");
    // const IgoClaimSigner = IgoClaimContract.connect(signer);
    // const igoClaim = IgoClaimSigner.attach(igoClaimAddr);

    // await igoClaim.payForTokens(ethers.utils.parseEther("200000"));
    // await igoClaim.claimTokens(ethers.utils.parseEther("200000"));
  });
});
