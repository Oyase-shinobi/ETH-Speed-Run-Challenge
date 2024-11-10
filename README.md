# ETH Speed Run Challenges

Welcome to my ETH Speed Run Challenges repository! This repository contains solutions for various Ethereum development challenges, each located in its own folder. Each challenge focuses on a unique aspect of Ethereum development, from basic contract deployment to building decentralized exchanges and creating state channels.

## Overview

The Ethereum Speed Run challenges are designed to take you through various aspects of Ethereum development, helping you to master core skills like smart contract creation, decentralized applications (dApps), and complex transaction handling. Each challenge folder contains:

- The smart contract(s) needed for the challenge.
- A frontend application to interact with the contracts (when applicable).
- Configuration and deployment scripts.
- Documentation specific to each challenge.

## Challenge Folders

### Challenge 0 - Simple NFT

**Folder:** `challenge-0-simple-nft`  
**Goal:** Create a basic NFT (Non-Fungible Token) contract, build a frontend for minting, transferring, and viewing NFTs, and deploy the dApp to a testnet and public server.  
**Key Topics:** NFTs, ERC721, smart contract deployment, React frontend.

### Challenge 1 - Staking Contract

**Folder:** `challenge-1-staker`  
**Goal:** Build a staking contract that collects ETH from multiple addresses. If a threshold is met by the deadline, the balance is sent to an external contract; otherwise, users can withdraw their funds.  
**Key Topics:** Contract funding, event logging, contract interactions.

### Challenge 2 - ERC20 Token & Vendor

**Folder:** `challenge-2-token-vendor`  
**Goal:** Create an ERC20 token contract and a Vendor contract that allows users to buy tokens. Build a frontend to interact with the Vendor contract, allowing users to view and buy tokens.  
**Key Topics:** ERC20 tokens, token vendor, payable functions, frontend interaction.

### Challenge 3 - Dice Game Exploit

**Folder:** `challenge-3-dice-game-exploit`  
**Goal:** Develop a contract that exploits weaknesses in a Dice Game contract to predict outcomes and consistently win.  
**Key Topics:** Blockchain randomness, security vulnerabilities, smart contract exploitation.

### Challenge 4 - Decentralized Exchange

**Folder:** `challenge-4-dex`  
**Goal:** Create a simple decentralized exchange for swapping an ERC20 token (`BAL`) and ETH. Users can connect their wallets, view balances, and buy/sell tokens based on a price formula.  
**Key Topics:** Decentralized exchanges, ERC20 token trading, React frontend.

### Challenge 5 - State Channel

**Folder:** `challenge-5-state-channel`  
**Goal:** Implement a simple state channel that allows a user (client) to interact with a service provider off-chain after depositing collateral on-chain.  
**Key Topics:** State channels, off-chain interactions, scalability solutions.

## Getting Started

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/Lukman-01/eth-speed-run-challenges.git
   cd eth-speed-run-challenges
   ```

2. **Install Dependencies**:
   Each challenge folder contains its own set of dependencies. Navigate into the desired challenge folder and install dependencies:
   ```bash
   cd challenge-0-simple-nft
   yarn install
   ```

3. **Compile Contracts**:
   Use Hardhat or the respective framework in each folder:
   ```bash
   yarn chain
   ```

4. **Deploy Contracts**:
   Deploy the contracts to a testnet:
   ```bash
   yarn deploy
   ```

5. **Run Frontend**:
   For challenges with frontends, start the development server:
   ```bash
   yarn start
   ```

## Deployment and Testing

Each challenge folder includes deployment scripts and test files:
- **Testing**: Run the test suite for each challenge to verify functionality.
  ```bash
  yarn  test
  ```
- **Deployment**: Deployment scripts are located in each folder’s `scripts` directory.
