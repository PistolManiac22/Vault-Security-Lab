# Vault Security Lab

This repository contains a small set of Solidity contracts for exploring vault security patterns and common vulnerabilities.

## Contracts

| Contract | Purpose |
| --- | --- |
| `VaultVulnerable.sol` | A deliberately insecure vault implementation for testing exploit scenarios. |
| `VaultSecure.sol` | A hardened vault implementation that demonstrates safer patterns. |
| `Attacker.sol` | A helper contract used to simulate attack flows against vulnerable vaults. |

## Getting Started

1. Install [Foundry](https://book.getfoundry.sh/getting-started/installation).
2. Run the tests from the repository root:

```bash
forge test
```

## Repository Layout

```
.
├── src        # Solidity contracts
└── test       # Foundry tests
```
