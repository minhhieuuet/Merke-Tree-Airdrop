const hre = require("hardhat");

async function main() {
  const airdrop = await hre.ethers.deployContract("Airdrop", [
    "0xcc537946c1576e69ba1923cf2e6c15544cf30404d9558dd538a6cb6322e65440",// merkele root
    "0xdac17f958d2ee523a2206206994597c13d831ec7"// token
  ]);
  await airdrop.waitForDeployment();
  console.log("Airdrop deployed to:", airdrop.target);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
