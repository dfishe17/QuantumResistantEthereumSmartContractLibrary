// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./interfaces/IQuantumResistant.sol";
import "./libraries/KyberMath.sol";

contract QuantumResistant is IQuantumResistant {
    using KyberMath for uint256;
    
    /// @notice Generate a public key from a seed
    /// @param seed Random seed for key generation
    /// @return Public key components
    function generatePublicKey(uint256 seed) external pure override returns (PublicKey memory) {
        uint256[] memory matrix = new uint256[](KyberMath.N);
        uint256[] memory seedArray = new uint256[](KyberMath.K);
        
        // Generate matrix elements
        for (uint256 i = 0; i < KyberMath.N; i++) {
            matrix[i] = KyberMath.generateRandom(seed, i);
        }
        
        // Generate seed elements
        for (uint256 i = 0; i < KyberMath.K; i++) {
            seedArray[i] = KyberMath.generateRandom(seed, KyberMath.N + i);
        }
        
        return PublicKey({
            matrix: matrix,
            seed: seedArray
        });
    }
    
    /// @notice Encrypt a message using the quantum-resistant scheme
    /// @param message The message to encrypt
    /// @param publicKey The recipient's public key
    /// @return Encrypted ciphertext
    function encrypt(bytes32 message, PublicKey memory publicKey) external pure override returns (Ciphertext memory) {
        require(publicKey.matrix.length == KyberMath.N, "Invalid matrix size");
        require(publicKey.seed.length == KyberMath.K, "Invalid seed size");
        
        // Generate random polynomials
        uint256[] memory r = new uint256[](KyberMath.N);
        for (uint256 i = 0; i < KyberMath.N; i++) {
            r[i] = KyberMath.generateRandom(uint256(message), i);
        }
        
        // Compute u = matrix * r
        uint256[] memory u = KyberMath.polyMul(publicKey.matrix, r);
        
        // Compute v = seed * r + message
        uint256[] memory v = new uint256[](KyberMath.N);
        uint256[] memory temp = KyberMath.polyMul(publicKey.seed, r);
        
        for (uint256 i = 0; i < KyberMath.N; i++) {
            v[i] = KyberMath.modAdd(temp[i], uint256(message) % KyberMath.PRIME_Q);
        }
        
        return Ciphertext({
            u: u,
            v: v
        });
    }
    
    /// @notice Verify the integrity of encrypted data
    /// @param ciphertext The encrypted data
    /// @param publicKey The public key used for encryption
    /// @return True if the ciphertext is valid
    function verifyIntegrity(Ciphertext memory ciphertext, PublicKey memory publicKey) external pure override returns (bool) {
        require(ciphertext.u.length == KyberMath.N, "Invalid u length");
        require(ciphertext.v.length == KyberMath.N, "Invalid v length");
        
        uint256[] memory check = KyberMath.polyMul(publicKey.matrix, ciphertext.u);
        
        // Verify that the ciphertext components are consistent
        for (uint256 i = 0; i < KyberMath.N; i++) {
            if (check[i] != ciphertext.v[i]) {
                return false;
            }
        }
        
        return true;
    }
}
