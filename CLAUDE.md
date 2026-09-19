# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```shell
forge build --sizes          # build (CI checks contract sizes too)
forge test -vvv              # run all tests, verbose traces on failure
forge test --match-test testFuzz_SetNumber   # run a single test by name
forge test --match-contract CounterTest      # run a single test contract
forge fmt                    # format
forge fmt --check            # check formatting only (what CI runs)
forge snapshot                # update gas snapshot (.gas-snapshot)
anvil                          # local node for the `localhost` rpc endpoint
```

Deploy/broadcast a script (uses a named account from an encrypted keystore, not a raw private key):
```shell
forge script script/Counter.s.sol --account <keystore-account-name> --broadcast --rpc-url <mainnet|sepolia|localhost>
```

Verify a deployed contract (path must be relative, no leading `/`):
```shell
forge verify-contract <address> src/Counter.sol:Counter --chain <mainnet|sepolia>
```

CI (`.github/workflows/*.yml`) runs, in order: `forge fmt --check`, `forge build --sizes`, `forge test -vvv`. Match that locally before pushing.

## Architecture

Standard Foundry layout:
- `src/` — contracts
- `test/` — Foundry tests (forge-std `Test`), one test file per contract, unit + fuzz tests
- `script/` — deployment/interaction scripts (forge-std `Script`, using `vm.startBroadcast()`/`vm.stopBroadcast()`)
- `lib/` — dependencies as git submodules (currently `forge-std` only); import paths are resolved via `remappings.txt` (`forge-std/=lib/forge-std/src/`), not by direct `lib/` paths
- Solidity version pinned in `foundry.toml` (`solc = "0.8.36"`) — keep this in sync with the version used to produce any previously-verified deployments, since verification requires an exact compiler match

### Config (`foundry.toml`)
- `[rpc_endpoints]` defines named aliases (`mainnet`, `sepolia`, `localhost`) so scripts/verification use `--rpc-url sepolia` etc. instead of raw URLs
- `[etherscan]` maps `mainnet`/`sepolia` to `ETHERSCAN_API_KEY` for `forge verify-contract`
- Actual URLs/keys live in `.env` (gitignored); `.env.example` documents the required variables (`MAINNET_RPC_URL`, `SEPOLIA_RPC_URL`, `ETHERSCAN_API_KEY`)

### Signing
Deployment accounts are managed via `cast wallet import <name> --interactive` (encrypted keystore in `~/.foundry/keystores/`), then referenced by name with `--account <name>` — never pass raw private keys on the command line.

## Solidity conventions (from AGENTS.md)
- Use Foundry tools only (forge, cast, anvil, chisel)
- Prefer forge-std testing utilities
- Keep functions small and focused; avoid unsafe patterns and unchecked external calls
- Every contract needs unit tests and fuzz tests where applicable, plus revert tests for failure paths
- Use `vm.assume` or `bound` to constrain fuzz inputs
- Add comments only when logic is non-obvious
