# Quantum Resistant Ethereum Smart Contract Library

# Quantum-Resistant Cryptography for Ethereum Smart Contracts

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
