const { ethers } = require("hardhat");

async function main() {
  const Eden = await ethers.getContractFactory("Eden");

  console.log("Deploying Eden contract...");
  const eden = await Eden.deploy();
  
  // Wait for deployment (Ethers v6)
  await eden.waitForDeployment();
  
  console.log("Eden deployed to:", await eden.getAddress());
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
