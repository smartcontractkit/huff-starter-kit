<br/>
<p align="center">
<a href="https://chain.link" target="_blank">
<img src="./img/chainlink-huff.png" width="225" alt="Chainlink Huff logo">
</a>
</p>
<br/>

A template repository for building a huff based smart contract project with Foundry.

For more information on using foundry with solidity, check out the [foundry-starter-kit](https://github.com/smartcontractkit/foundry-starter-kit)

Implementation of the following 2 Chainlink features using the [Foundry](https://book.getfoundry.sh/getting-started/installation.html) & [Huff](https://huff.sh/) development environment:

- [Chainlink Price Feeds](https://docs.chain.link/docs/using-chainlink-reference-contracts)
- [Chainlink Keepers](https://docs.chain.link/docs/chainlink-keepers/introduction/)

# Table Of Contents

- [Table Of Contents](#table-of-contents)
- [Getting Started](#getting-started)
  - [Requirements](#requirements)
  - [Quickstart](#quickstart)
  - [Testing](#testing)
- [Usage](#usage)
  - [Deploying to a local network](#deploying-to-a-local-network)
  - [Deploying to a testnet or mainnet network](#deploying-to-a-testnet-or-mainnet-network)
    - [Setup](#setup)
    - [Deploying](#deploying)
- [Misc](#misc)
  - [Disclaimer](#disclaimer)
  - [Acknowledgments](#acknowledgments)
  - [Contributing](#contributing)
  - [Resources](#resources)
  - [Helpful Debugging Resources:](#helpful-debugging-resources)

# Getting Started

## Requirements

Please install the following:

- [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
  - You'll know you've done it right if you can run `git --version`
- [Foundry / Foundryup](https://github.com/gakonst/foundry)
  - This will install `forge`, `cast`, and `anvil`
  - You can test you've installed them right by running `forge --version` and get an output like: `forge 0.2.0 (f016135 2022-07-04T00:15:02.930499Z)`
  - To get the latest of each, just run `foundryup`
- [Huff Compiler](https://docs.huff.sh/get-started/installing/)
  - You'll know you've done it right if you can run `huffc --version` and get an output like: `huffc 0.2.0`

## Quickstart

```sh
git clone https://github.com/smartcontractkit/huff-starter-kit
cd huff-starter-kit
make # This installs the project's dependencies.
make test
```

## Testing

```
make test
```

or

```
forge test
```

# Usage

Deploying to a network uses the [foundry scripting system](https://book.getfoundry.sh/tutorials/solidity-scripting.html), where you write your deploy scripts in solidity!

## Deploying to a local network

Foundry comes with local network [anvil](https://book.getfoundry.sh/anvil/index.html) baked in, and allows us to deploy to our local network for quick testing locally.

To start a local network run:

```
make anvil
```

This will spin up a local blockchain with a determined private key, so you can use the same private key each time.

Then, you can deploy it with:

```
make deploy-anvil contract=<CONTRACT_NAME>
```

## Deploying to a testnet or mainnet network

### Setup

We'll demo using the Sepolia testnet. (Go here for [testnet sepolia ETH](https://faucets.chain.link/).)

You'll need to add the following variables to a `.env` file:

- `SEPOLIA_RPC_URL`: A URL to connect to the blockchain. You can get one for free from [Infura](https://infura.io/).
- `PRIVATE_KEY`: A private key from your wallet. You can get a private key from a new [Metamask](https://metamask.io/) account
  - Additionally, if you want to deploy to a testnet, you'll need test ETH and/or LINK. You can get them from [faucets.chain.link](https://faucets.chain.link/).
- Optional `ETHERSCAN_API_KEY`: If you want to verify on etherscan.

### Deploying

```
make deploy-sepolia contract=<CONTRACT_NAME>
```

For example:

```
make deploy-sepolia contract=PriceFeedConsumer
```

This will run the forge script, the script it's running is:

```
@forge script script/${contract}.s.sol:Deploy${contract} --rpc-url ${SEPOLIA_RPC_URL}  --private-key ${PRIVATE_KEY} --broadcast --verify --etherscan-api-key ${ETHERSCAN_API_KEY}  -vvvv
```

If you don't have an `ETHERSCAN_API_KEY`, you can also just run:

```
@forge script script/${contract}.s.sol:Deploy${contract} --rpc-url ${SEPOLIA_RPC_URL}  --private-key ${PRIVATE_KEY} --broadcast
```

These pull from the files in the `script` folder.

# Misc

## Disclaimer

> None of the contacts have been audited, use at your own risk.

## Acknowledgments

- [Huff Project Template](https://github.com/huff-language/huff-project-template/tree/main/src)
- [Huff Examples](https://github.com/huff-language/huff-examples)

## Contributing

Contributions are always welcome! Open a PR or an issue!

Thank You!

## Resources

- [Chainlink Documentation](https://docs.chain.link/)
- [Foundry Documentation](https://book.getfoundry.sh/)
- [Huff Documentation](https://docs.huff.sh/)

## Helpful Debugging Resources:

- [evm.codes](https://www.evm.codes/)
- [evm.codes playground](https://www.evm.codes/playground)
- [Huff VSCode Debugger & Highlighter](https://github.com/huff-language/vscode-huff)
