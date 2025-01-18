# Quantum Resistant Ethereum Smart Contract Library

This library implements quantum-resistant cryptography suitable for Ethereum smart contracts, based on lattice-based cryptography principles.

## Installation

### Using npm (for Hardhat/Truffle projects)
```bash
npm install @replit/quantum-resistant-solidity
```

### Direct Import in Solidity (Remix/Direct)
```solidity
import "@replit/quantum-resistant-solidity/contracts/QuantumResistant.sol";
```

## Usage

1. Basic Integration:
```solidity
import "@replit/quantum-resistant-solidity/contracts/QuantumResistant.sol";

contract YourContract {
    QuantumResistant private qr;
    
    constructor() {
        qr = new QuantumResistant();
    }
    
    function encryptMessage(bytes32 message, IQuantumResistant.PublicKey memory publicKey) 
        external view returns (IQuantumResistant.Ciphertext memory) {
        return qr.encrypt(message, publicKey);
    }
}
```

2. Key Generation:
```solidity
IQuantumResistant.PublicKey memory pubKey = qr.generatePublicKey(yourRandomSeed);
```

3. Encryption:
```solidity
IQuantumResistant.Ciphertext memory encrypted = qr.encrypt(yourMessage, pubKey);
```

4. Integrity Verification:
```solidity
bool isValid = qr.verifyIntegrity(encrypted, pubKey);
```

## Features

- Quantum-resistant encryption using lattice-based cryptography
- Compatible with Ethereum smart contracts
- Gas-optimized implementation
- Comprehensive testing suite

## Security Considerations

- Use strong random seeds for key generation
- Keep private keys secure off-chain
- Verify data integrity after encryption
- Consider gas costs for large-scale operations

## Example Implementation

See `contracts/examples/QuantumResistantExample.sol` for a complete implementation example.

## Development

1. Install dependencies:
```bash
npm install
```

2. Run tests:
```bash
npx hardhat test
```

## License

MIT

For Jetpack usage: 

Jetpack Installation:

Add the library to jetpack.json with "@replit/quantum-resistant-solidity": "^1.0.0"

Run jetpack install

Easy Smart Contract Integration:

Direct import: import "@replit/quantum-resistant-solidity/contracts/QuantumResistant.sol"

Basic usage shown in QuantumResistantExample.sol

Advanced patterns in SecureStorage.sol and QuantumVoting.sol

Example Integration Methods:

Basic encryption functions

Key management systems

Integration with OpenZeppelin contracts

Complete secure messaging implementation

Would you like me to explain any specific integration pattern in more detail or show you how to implement a particular quantum-resistant feature?
