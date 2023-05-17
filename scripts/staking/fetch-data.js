
async function main() {
  const spin = "0x6AA217312960A21aDbde1478DC8cBCf828110A67";
  const wbnb = "0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c";
  const spin_bnb_farm = "0x6D28F46E0698a2F217c72fF4e86DBFBAc422B1C4";
  const spin_bnb_lp = "0x89c68051543Fa135B31c2CE7BD8Cdf392345FF01";
  const bnb_busd_lp = "0x58F876857a02D6762E0101bb5C46A8c1ED44Dc16";
  const DataServer = await ethers.getContractFactory("DataServer");
  const dataServer = await DataServer.deploy();
  await dataServer.deployed();
  console.log("DataServer deployed to:", dataServer.address);

  let result = await dataServer.getFarmData(
    wbnb,
    bnb_busd_lp,
    spin,
    spin_bnb_lp,
    spin_bnb_farm
  )
  console.log("Result:", result)
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
