-include .env

.PHONY: all test deploy mint verify deployMood

help:
	@echo "Usage:"
	@echo " make deploy [ARGS=...]"

build:; forge build

install :; forge install Cyfrin/foundry-devops@0.0.11 --no-commit && forge install foundry-rs/forge-std@v1.5.3 --no-commit && forge install OpenZeppelin/openzeppelin-contracts 

test:; forge test

NETWORK_ARGS := --rpc-url http//localhost:8545 --private-key $(PRIVATE_KEY_ANVIL) --broadcast

ifeq ($(findstring --network sepolia, $(ARGS)),--network sepolia)
	NETWORK_ARGS := --rpc-url $(SEPOLIA_RPC_URL) --private-key $(PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY)
endif

deploy:
	@forge script script/DeployBasicNft.s.sol:DeployBasicNft $(NETWORK_ARGS)

mint:
	@forge script script/Interaction.s.sol:BasicNftMint $(NETWORK_ARGS)
verify:
	@forge verify-contract --chain-id 11155111 --etherscan-api-key $(ETHERSCAN_API_KEY) 0x7BF67DA35AbaCDC34d42Cf285769162d89677f9A src/BasicNft.sol:BasicNft

deployMood:
	@forge script script/DeployMoodNft.s.sol:DeployMoodNft $(NETWORK_ARGS)

flipMood:
	@cast 0x17a213af45b2Ac32Be0637CB583386a6BcD1C463 "flipMood()"