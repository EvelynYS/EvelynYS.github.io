const hre = require("hardhat");
const { ethers } = require("hardhat");
const tokens = (n) => {
  return ethers.parseUnits(n.toString(), "ether");
};

async function main() {
  let buyer, seller, inspector, lender;
  // Setup accounts
  [buyer, seller, inspector, lender] = await ethers.getSigners();

  // Deploy Real Estate
  const RealEstate = await ethers.getContractFactory("RealEstate");
  const realEstate = await RealEstate.deploy();
  await realEstate.waitForDeployment();
  
  console.log(`Deployed Real Estate Contract at: ${realEstate.target}`);
  console.log("Minting 3 properties...\n");

  let transaction = await realEstate
    .connect(seller)
    .mint(
      "https://ipfs.filebase.io/ipfs/QmPsEZMbGTp3mdLidLHXFUtaQiJqNrZhMg69A797rfLcvP/ModernHouse.json"
    );
  await transaction.wait();

  transaction = await realEstate
    .connect(seller)
    .mint(
      "https://ipfs.filebase.io/ipfs/QmPsEZMbGTp3mdLidLHXFUtaQiJqNrZhMg69A797rfLcvP/PentHouse.json"
    );
  await transaction.wait();

  transaction = await realEstate
    .connect(seller)
    .mint(
      "https://ipfs.filebase.io/ipfs/QmPsEZMbGTp3mdLidLHXFUtaQiJqNrZhMg69A797rfLcvP/Suite.json"
    );
  await transaction.wait();

  const totalSupply = await realEstate.totalSupply();
  console.log(`Total supply after minting: ${totalSupply.toString()}`);

  // 验证每个token的URI
  for (let i = 1; i <= totalSupply; i++) {
    const tokenURI = await realEstate.tokenURI(i);
    console.log(`Token ${i} URI: ${tokenURI}`);
  }

  //Deploy Escrow
  const Escrow = await ethers.getContractFactory("Escrow");
  const escrow = await Escrow.deploy(
    realEstate.target,
    seller.address,
    inspector.address,
    lender.address
  );
  await escrow.waitForDeployment();
  console.log(`Escrow:${escrow.target}`)

  for (let i = 0; i < 3; i++) {
    let transaction = await realEstate
      .connect(seller)
      .approve(escrow.target, i + 1);
    await transaction.wait();
  }

  //Listing properties
  transaction = await escrow
    .connect(seller)
    .list(1, buyer.address, tokens(20), tokens(10));
  await transaction.wait();

  transaction = await escrow
    .connect(seller)
    .list(2, buyer.address, tokens(15), tokens(5));
  await transaction.wait();

  transaction = await escrow
    .connect(seller)
    .list(3, buyer.address, tokens(10), tokens(5));
  await transaction.wait();

  console.log('Finished.')
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

