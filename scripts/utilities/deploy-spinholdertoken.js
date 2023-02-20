async function main() {
  const spin = "0x35f80a39eeFe33D0dfD2aD2daa6aD6A9D472CEbd";
  const pool = "0x4Fc1F5EF6886a446637FFfF76F8C4D79EDF395CF";
  const farm = "0x25ab8675C57B4A6Da14677e1353bC59d613F69b5";
  const vault = "0x03447d28FC19cD3f3cB449AfFE6B3725b3BCdA77";

  const SHT = await ethers.getContractFactory("SpinHolderToken");
  const sht = await SHT.deploy(spin, pool, farm, vault);
  await sht.deployed();
  console.log("SHT deployed: ", sht.address);
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
