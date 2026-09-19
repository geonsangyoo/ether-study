## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

- **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
- **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
- **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
- **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

Deployment is wrapped by the `Makefile`, which reads `ACCOUNT` from `.env` (your `cast wallet import` keystore name) and broadcasts via the `sepolia`/`mainnet` RPC aliases defined in `foundry.toml`.

```shell
# local (anvil must be running; uses anvil's default account, no keystore needed)
$ make deploy-local script/Counter.s.sol

# broadcast a deployment
$ make deploy-testnet script/Counter.s.sol
$ make deploy-mainnet script/Counter.s.sol

# simulate only, without broadcasting (pass dry as an extra argument)
$ make deploy-testnet script/Counter.s.sol dry
$ make deploy-mainnet script/Counter.s.sol dry
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
