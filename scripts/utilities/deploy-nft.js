async function main() {
  const NFT = await ethers.getContractFactory("SpintopNFT");
  const nft = await NFT.deploy();
  await nft.waitForDeployment();

  console.log("NFT deployed: ", nft.target);
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
