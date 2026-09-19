include .env
export

.PHONY: deploy-local deploy-testnet deploy-mainnet dry

# Anvil's well-known default account #0 (public, funded only on local anvil, never use on a live network)
ANVIL_PRIVATE_KEY := 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80

# extra positional word on the command line (e.g. `make deploy-mainnet script/Counter.s.sol`) is the script path
SCRIPT := $(filter-out deploy-local deploy-testnet deploy-mainnet dry,$(MAKECMDGOALS))

# --verify only makes sense alongside a real broadcast, so it rides along with --broadcast and drops out on a dry run
BROADCAST_FLAGS := $(if $(filter dry,$(MAKECMDGOALS)),,--broadcast --verify)

deploy-local: guard-SCRIPT
	forge script $(SCRIPT) --rpc-url localhost --private-key $(ANVIL_PRIVATE_KEY) $(BROADCAST_FLAGS)

deploy-testnet: guard-ACCOUNT guard-SCRIPT
	forge script $(SCRIPT) --account $(ACCOUNT) --rpc-url sepolia $(BROADCAST_FLAGS)

deploy-mainnet: guard-ACCOUNT guard-SCRIPT
	forge script $(SCRIPT) --account $(ACCOUNT) --rpc-url mainnet $(BROADCAST_FLAGS)

dry: ;

$(SCRIPT): ;

guard-ACCOUNT:
	@test -n "$(ACCOUNT)" || (echo "ACCOUNT is not set. Add ACCOUNT=<keystore-account-name> to .env" && exit 1)

guard-SCRIPT:
	@test -n "$(SCRIPT)" || (echo "SCRIPT is not set. Usage: make deploy-testnet script/Counter.s.sol" && exit 1)
