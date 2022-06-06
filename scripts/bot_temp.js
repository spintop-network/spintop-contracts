async function main() {
  const SpinToken = await ethers.getContractFactory("ERC20");
  const spinToken = SpinToken.attach(
    "0x6AA217312960A21aDbde1478DC8cBCf828110A67"
  );
  //   const target = 1653013800;
  let notified = false;
  setInterval(async () => {
    let now = Date.now();
    now = parseInt(now / 1000);
    console.log(now);
    if (now >= 1652997540 && !notified) {
      let balance = await spinToken.balanceOf(
        "0xC370b50eC6101781ed1f1690A00BF91cd27D77c4"
      );
      console.log("Balance: ", balance);
      notified = true;
    }
  }, 10000);
}
main();
