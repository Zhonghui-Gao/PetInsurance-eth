## <div align="center"> Pet Insurance Smart Contract 🐱🐶</div>

This project is a pet insurance smart contract developed with the Truffle framework, deployed on the Ethereum blockchain. It allows users to purchase insurance for their pets, submit claims, and handle these claims.

## Features

**· Purchase Insurance**: Users can buy insurance for their pets.  
**· Submit Claims**: Insurance holders can submit claims for their pet's medical treatments.  
**· Claim Review**: Contract owners can review and process claims.  

## Quick Start

Follow these instructions to get the project set up and running on your local machine for development and testing purposes.(window/linux/mac)

### Prerequisites

Ensure you have the following installed:

* [Node.js](https://nodejs.org/en)(v12 or higher)
* [Truffle](`npm install -g truffle`)
* [Ganache](https://archive.trufflesuite.com/ganache/)for a personal Ethereum blockchain
* [MetaMask](https://metamask.io/)

Version:
```bash
Truffle v5.11.5 (core: 5.11.5)
Ganache v7.9.1
Solidity - 0.8.21 (solc-js)
Node v20.12.1
Web3.js v1.10.0
```
## Installing
1. #### Clone the repository
```bash
git clone https://github.com/Zhonghui-Gao/PetInsurance-eth.git
cd <filename>
```
2. #### Start Ganache
    Launch Ganache and create a new Ethereum blockchain workspace.
   
3. #### Compile contracts
    ` truffle compile `

4. #### Migrate contracts
    `truffle migrate --reset`

5. #### Run demo
    `truffle test`