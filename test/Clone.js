const hre = require("hardhat");
const { expect } = require("chai");

describe("Clone", function () {
  describe("Clone", function () {
    before(async () => {
      const ERC20 = await hre.ethers.getContractFactory("Token");
      const Clone = await hre.ethers.getContractFactory("CloneFactory");

      token = await ERC20.deploy();
      cloneFactory = await Clone.deploy();
    })

    it("Could clone", async function () {
      const bytecode0 = await hre.ethers.provider.getCode(token.target);

      const cloneAddress = await cloneFactory.clone.staticCall(token.target);

      await cloneFactory.clone(token.target);
      const bytecode1 = await hre.ethers.provider.getCode(cloneAddress);
      
      expect(bytecode0).to.equal(bytecode1);
      expect(token.target).to.not.equal(cloneAddress);
    });

    it("Could clone2", async function () {
      const salt = "0x0102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f20";
      const bytecode0 = await hre.ethers.provider.getCode(token.target);

      const cloneAddress = await cloneFactory.clone2.staticCall(token.target, salt);

      await cloneFactory.clone2(token.target, salt);
      const bytecode1 = await hre.ethers.provider.getCode(cloneAddress);
      
      expect(bytecode0).to.equal(bytecode1);
      expect(token.target).to.not.equal(cloneAddress);

      const predictedAddress = await cloneFactory.predictClonedAddress(token.target, salt);
      expect(predictedAddress).to.equal(cloneAddress);
    });

  });
});
