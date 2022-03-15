describe("Payment", function () {
  it("Should add new balance", async function () {
    const poolAddress = "0x06F2bA50843e2D26D8FD3184eAADad404B0F1A67";
    const spinAddress = "0x6AA217312960A21aDbde1478DC8cBCf828110A67";
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

    const SpinVaultContract = await ethers.getContractFactory("SpinVault");
    const SpinVault = SpinVaultContract.connect(signer);
    const spinVault = await SpinVault.deploy(
      "Spinstarter Shares",
      "SSS",
      poolAddress,
      spinAddress
    );
    await spinVault.deployed();
    console.log("SpinVault deployed: ", spinVault.address);
    await spinVault.createIGO("Spinstarter King", "spinKing", date);
    const igo = await spinVault.getIGO(0);
    console.log("First IGO's address: ", igo);

    await spinVault.createIGO("Spinstarter Queen", "spinQueen", date);
    const igo2 = await spinVault.getIGO(1);
    console.log("Second IGO's address: ", igo2);

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

    const IgoContract = await ethers.getContractFactory("IGO");
    const IgoSigner = IgoContract.connect(signer);
    const igo_ = IgoSigner.attach(igo);
    const igo2_ = IgoSigner.attach(igo2);
    await igo_.start(ethers.utils.parseEther("10000"));
    await igo2_.start(ethers.utils.parseEther("10000"));
    const reward1 = await igo_.earned(DEPLOYER);
    console.log("Reward#1: ", reward1);

    await network.provider.send("evm_increaseTime", [300]);
    await network.provider.send("evm_mine");
    await spinVault.deposit(ethers.utils.parseEther("1000"));
    const reward2 = await igo_.earned(DEPLOYER);
    console.log("Reward#2: ", reward2);
  });
});
