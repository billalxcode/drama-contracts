import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

const INFURA_KEY_ID = process.env.INFURA_KEY_ID || "" // Set your infura id
const ETHERSCAN_KEY = process.env.ETHERSCAN_KEY || "" // Set your etherscan key

const MY_ACCOUNTS: Array<string> = [
  "0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80",
  "0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d",
  "0x5de4111afa1a4b94908f83103eb1f1706367c2e68ca870fc3fb9a804cdab365a",
]

const config: HardhatUserConfig = {
  solidity: "0.8.24",

  networks: {
    local: {
      url: "http://localhost:8545",
      accounts: MY_ACCOUNTS,
    },
    sepolia: {
      url: `https://sepolia.infura.io/v3/${INFURA_KEY_ID}`,
      accounts: MY_ACCOUNTS,
    },
    mainnet: {
      url: `https://mainnet.infura.io/v3/${INFURA_KEY_ID}`,
    }
  },

  etherscan: {
    apiKey: ETHERSCAN_KEY
  }
}

export default config;
