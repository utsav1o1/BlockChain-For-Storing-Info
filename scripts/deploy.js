// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

async function main() {
  try {
    // Compile contracts
    await hre.run("compile");

    // Deploy ExInfo contract
    const ExInfo = await hre.ethers.getContractFactory("ExInfo");
    const exInfo = await ExInfo.deploy();
    await exInfo.deployed();

    console.log(`ExInfo contract deployed to: ${exInfo.address}`);
  } catch (error) {
    console.error(error);
    process.exitCode = 1;
  }

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors. 
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
