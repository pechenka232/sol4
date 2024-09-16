const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("MyToken", function () {
    it("Should deploy and mint tokens", async function () {
        const [owner] = await ethers.getSigners();
        const Token = await ethers.getContractFactory("MyToken");
        const token = await Token.deploy();
        await token.deployed();

        expect(await token.balanceOf(owner.address)).to.equal(10000);
    });
});
