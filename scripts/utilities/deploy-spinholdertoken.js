async function main() {
  const spin = "0x6AA217312960A21aDbde1478DC8cBCf828110A67";
  const pool = "0x06F2bA50843e2D26D8FD3184eAADad404B0F1A67";
  const farm = "0x6D28F46E0698a2F217c72fF4e86DBFBAc422B1C4";
  const vault = "0x03447d28FC19cD3f3cB449AfFE6B3725b3BCdA77";

  const SHT = await ethers.getContractFactory("SpinHolderToken");
  const sht = await SHT.deploy(spin, pool, farm, vault);
  await sht.waitForDeployment();
  console.log("SHT deployed: ", sht.target);
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
