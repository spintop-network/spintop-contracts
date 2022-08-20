const { ethers } = require("hardhat");

// Triangular arbitrage testing

async function main() {
  const abiLP = require("./ABI").abiLP;
  const abiRouter = require("./ABI").abiRouter;
  const abiERC20 = require("./ABI").abiERC20;

  //   const owner = await ethers.getSigner();
  //   await hre.network.provider.request({
  //     method: "hardhat_impersonateAccount",
  //     params: ["0x8894E0a0c962CB723c1976a4421c95949bE2D4E3"],
  //   });

  const addrs = {
    spinBnb: "0x89c68051543Fa135B31c2CE7BD8Cdf392345FF01",
    spinTrivia: "0xe93277E2216a39532bdbFAD66744b1A3fc569b30",
    triviaBnb: "0xef642c40eebbc964881dd7bd1a0b50e90441e73a",
    router: "0x10ED43C718714eb63d5aA57B78B54704E256024E",
    spin: "0x6AA217312960A21aDbde1478DC8cBCf828110A67",
    wbnb: "0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c",
    trivia: "0xb465f3cb6aba6ee375e12918387de1eac2301b05",
  };

  const router = new ethers.Contract(addrs.router, abiRouter, owner);
  const spinBNB = new ethers.Contract(addrs.spinBnb, abiLP, owner); // token_0=spin, token_1=bnb
  const spinTrivia = new ethers.Contract(addrs.spinTrivia, abiLP, owner); // token_0=spin, token_1=trivia
  const triviaBNB = new ethers.Contract(addrs.triviaBnb, abiLP, owner); // token_0=trivia, token_1=wbnb

  const wbnb = new ethers.Contract(addrs.wbnb, abiERC20, owner);

  const approve = await wbnb.approve(addrs.router, ethers.constants.MaxUint256);
  await approve.wait();

  const spinBNB_reserves = await spinBNB.getReserves();
  const ratio_0 = spinBNB_reserves[1] / spinBNB_reserves[0]; // bnb -> spin
  const spinTrivia_reserves = await spinTrivia.getReserves();
  const ratio_1 = (spinTrivia_reserves[0] / spinTrivia_reserves[1]) * 1e15; // spin -> trivia
  const triviaBNB_reserves = await triviaBNB.getReserves();
  const ratio_2 = triviaBNB_reserves[0] / triviaBNB_reserves[1] / 1e15;
  const diff = ratio_0 * ratio_1 * ratio_2;
  console.log("Diff:", diff);

  const input = 1;

  const spinBNB_amountOut = await router.getAmountOut(ethers.utils.parseEther(input.toString()), spinBNB_reserves[1], spinBNB_reserves[0]);
  const spinTrivia_amountOut = await router.getAmountOut(spinBNB_amountOut, spinTrivia_reserves[0], spinTrivia_reserves[1]);
  const triviaBNB_amountOut = await router.getAmountOut(spinTrivia_amountOut, triviaBNB_reserves[0], triviaBNB_reserves[1]);

  // calc min
  const max_slippage = 0.03;
  const min_amount = (1 - max_slippage) * input;
  const now = parseInt(Date.now() / 1000) + 30;

  const route_0_gas = await router.estimateGas.swapExactTokensForTokens(
    ethers.utils.parseEther(input.toString()),
    // spinBNB_amountOut.mul(0.97),
    0,
    [addrs.wbnb, addrs.spin],
    owner.getAddress(),
    now
  );
  console.log("Route_0 gas: ", ethers.utils.formatEther(route_0_gas));

  const final = ethers.utils.formatEther(triviaBNB_amountOut);
  console.log("Final out: ", final);
  const profit = final - input;
  console.log("Profit: ", profit);
}
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
