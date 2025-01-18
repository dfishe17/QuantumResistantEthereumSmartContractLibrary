// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "../QuantumResistant.sol";

contract QuantumResistantTest {
    QuantumResistant private qr;
    
    constructor() {
        qr = new QuantumResistant();
    }
    
    function testEncryptionWorkflow() external view returns (bool) {
        // Generate a test message
        bytes32 message = keccak256("Test message");
        
        // Generate public key
        IQuantumResistant.PublicKey memory pubKey = qr.generatePublicKey(12345);
        
        // Encrypt message
        IQuantumResistant.Ciphertext memory encrypted = qr.encrypt(message, pubKey);
        
        // Verify integrity
        return qr.verifyIntegrity(encrypted, pubKey);
    }
    
    function testKeyGeneration(uint256 seed) external view returns (bool) {
        IQuantumResistant.PublicKey memory pubKey = qr.generatePublicKey(seed);
        return pubKey.matrix.length == 256 && pubKey.seed.length == 3;
    }
}
