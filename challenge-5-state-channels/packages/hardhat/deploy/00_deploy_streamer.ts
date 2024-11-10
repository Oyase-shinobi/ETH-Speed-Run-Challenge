import { HardhatRuntimeEnvironment } from "hardhat/types";
import { DeployFunction } from "hardhat-deploy/types";
 
const deployStreamer: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {

  const { deployer } = await hre.getNamedAccounts();
  const { deploy } = hre.deployments;

  await deploy("Streamer", {
    from: deployer,
    args: [],
    log: true,
    autoMine: true,
  });

  // // *Checkpoint 1*
  // // Get the deployed contract
  const streamer = await hre.ethers.getContract("Streamer", deployer);

  // Transfer ownership to your front end address
  console.log("\n 🤹  Sending ownership to frontend address...\n");
  const ownerTx = await streamer.transferOwnership("0x40feacdeee6f017fA2Bc1a8FB38b393Cf9022d71");
  console.log("\n       confirming...\n");
  const ownershipResult = await ownerTx.wait();
  if (ownershipResult) {
    console.log("       ✅ ownership transferred successfully!\n");
  }
};

export default deployStreamer;

deployStreamer.tags = ["Streamer"];
