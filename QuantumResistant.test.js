const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("QuantumResistant", function () {
    let quantumResistant;
    let quantumResistantTest;
    
    beforeEach(async function () {
        const QuantumResistant = await ethers.getContractFactory("QuantumResistant");
        quantumResistant = await QuantumResistant.deploy();
        await quantumResistant.deployed();
        
        const QuantumResistantTest = await ethers.getContractFactory("QuantumResistantTest");
        quantumResistantTest = await QuantumResistantTest.deploy();
        await quantumResistantTest.deployed();
    });
    
    describe("Key Generation", function () {
        it("Should generate valid public keys", async function () {
            const result = await quantumResistantTest.testKeyGeneration(123456);
            expect(result).to.be.true;
        });
    });
    
    describe("Encryption Workflow", function () {
        it("Should successfully encrypt and verify", async function () {
            const result = await quantumResistantTest.testEncryptionWorkflow();
            expect(result).to.be.true;
        });
    });
    
    describe("Gas Optimization", function () {
        it("Should have reasonable gas costs", async function () {
            const tx = await quantumResistant.generatePublicKey(123456);
            const receipt = await tx.wait();
            expect(receipt.gasUsed).to.be.below(3000000);
        });
    });
});
