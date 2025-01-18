// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

library KyberMath {
    // Parameters for the simplified Kyber implementation
    uint256 constant internal PRIME_Q = 3329;
    uint256 constant internal K = 3;
    uint256 constant internal N = 256;
    
    /// @notice Perform modular addition
    /// @param a First number
    /// @param b Second number
    /// @return Result of (a + b) mod q
    function modAdd(uint256 a, uint256 b) internal pure returns (uint256) {
        return addmod(a, b, PRIME_Q);
    }
    
    /// @notice Perform modular multiplication
    /// @param a First number
    /// @param b Second number
    /// @return Result of (a * b) mod q
    function modMul(uint256 a, uint256 b) internal pure returns (uint256) {
        return mulmod(a, b, PRIME_Q);
    }
    
    /// @notice Generate a pseudo-random number
    /// @param seed Input seed
    /// @param index Nonce for randomness
    /// @return Pseudo-random number
    function generateRandom(uint256 seed, uint256 index) internal pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(seed, index))) % PRIME_Q;
    }
    
    /// @notice Perform polynomial multiplication
    /// @param a First polynomial
    /// @param b Second polynomial
    /// @return Result polynomial
    function polyMul(uint256[] memory a, uint256[] memory b) internal pure returns (uint256[] memory) {
        require(a.length == N && b.length == N, "Invalid polynomial length");
        
        uint256[] memory result = new uint256[](N);
        
        for (uint256 i = 0; i < N; i++) {
            for (uint256 j = 0; j < N; j++) {
                uint256 idx = (i + j) % N;
                result[idx] = modAdd(result[idx], modMul(a[i], b[j]));
            }
        }
        
        return result;
    }
}
