const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Eden Contract", function () {
  let Eden;
  let eden;
  let owner;
  let addr1;

  beforeEach(async function () {
    // Get the ContractFactory and Signers
    Eden = await ethers.getContractFactory("Eden");
    [owner, addr1] = await ethers.getSigners();

    // Deploy the contract
    eden = await Eden.deploy(); // No need for .deployed()
  });

  describe("Deployment", function () {
    it("Should set the correct name and symbol", async function () {
      expect(await eden.name()).to.equal("Eden");
      expect(await eden.symbol()).to.equal("EDEN");
    });

    it("Should mint a token with tokenId 0", async function () {
      // Mint a token
      await eden.mint();

      // Check the owner of tokenId 0
      expect(await eden.ownerOf(0)).to.equal(owner.address);
    });
  });

  describe("Token URI", function () {
    it("Should return the correct tokenURI for tokenId 0", async function () {
      // Mint a token
      await eden.mint();

      // Get the tokenURI
      const tokenURI = await eden.tokenURI(0);

      // Decode the Base64-encoded JSON metadata
      const base64Json = tokenURI.split(",")[1];
      const jsonString = Buffer.from(base64Json, "base64").toString("utf-8");
      const metadata = JSON.parse(jsonString);

      // Verify the metadata
      expect(metadata.name).to.equal("Garden of Eden");
      expect(metadata.description).to.equal("A depiction of the Garden of Eden as an NFT.");
      expect(metadata.image).to.include("data:image/svg+xml;base64");
    });

    it("Should revert for invalid tokenId", async function () {
      // Attempt to get tokenURI for a non-existent tokenId
      await expect(eden.tokenURI(1)).to.be.revertedWith("Token ID not found");
    });
  });
});