// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

interface IQuantumResistant {
    /// @notice Struct to hold public key components
    struct PublicKey {
        uint256[] matrix;
        uint256[] seed;
    }

    /// @notice Struct to hold encrypted data
    struct Ciphertext {
        uint256[] u;
        uint256[] v;
    }

    /// @dev Generate a new key pair
    /// @param seed Random seed for key generation
    /// @return Public key components
    function generatePublicKey(uint256 seed) external pure returns (PublicKey memory);

    /// @dev Encrypt a message using the quantum-resistant scheme
    /// @param message The message to encrypt
    /// @param publicKey The recipient's public key
    /// @return Encrypted ciphertext
    function encrypt(bytes32 message, PublicKey memory publicKey) external pure returns (Ciphertext memory);

    /// @dev Verify the integrity of encrypted data
    /// @param ciphertext The encrypted data
    /// @param publicKey The public key used for encryption
    /// @return True if the ciphertext is valid
    function verifyIntegrity(Ciphertext memory ciphertext, PublicKey memory publicKey) external pure returns (bool);
}
