require("dotenv").config();
require("@nomicfoundation/hardhat-toolbox");
require("@nomicfoundation/hardhat-verify");
require("hardhat-gas-reporter");
require("hardhat-tracer");
require("@nomicfoundation/hardhat-foundry");
require('@openzeppelin/hardhat-upgrades');

module.exports = {
  solidity: {
    compilers: [
      {
        version: "0.8.0",
        settings: {
          optimizer: {
            enabled: true,
            runs: 200
          }
        }
      },
      {
        version: "0.8.15",
        settings: {
          optimizer: {
            enabled: true,
            runs: 200
          }
        }
      },
      {
        version: "0.8.21",
        settings: {
          optimizer: {
            enabled: true,
            runs: 200
          }
        }
      },
      {
        version: "0.8.23",
        settings: {
          optimizer: {
            enabled: true,
            runs: 200
          }
        }
      },
      {
        version: "0.8.1"
      }
    ],
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  },
  networks: {
    hardhat: {
      forking: {
        url: process.env.RPC_URL || "",
        accounts: process.env.PRIVATE_KEY !== undefined ? [process.env.PRIVATE_KEY] : []
      }
    },

    binance: {
      url: process.env.RPC_URL || "https://bsc-dataseed.binance.org/",
      accounts: process.env.PRIVATE_KEY !== undefined ? [process.env.PRIVATE_KEY] : [],
      gasPrice: 3000000000
    },
    bsctestnet: {
      url: process.env.BSC_TESTNET_URL || "https://data-seed-prebsc-1-s1.binance.org:8545/",
      accounts: process.env.PRIVATE_KEY !== undefined ? [process.env.PRIVATE_KEY] : []
    },
    polygon: {
      url: process.env.POLYGON_URL || "",
      accounts: process.env.PRIVATE_KEY !== undefined ? [process.env.PRIVATE_KEY] : []
    }
  },
  etherscan: {
    apiKey: "QH3QDHPBQ65XU2D98M3I6DNXK35BV6AWDJ"
  },
  sourcify: {
    // Disabled by default
    // Doesn't need an API key
    enabled: true
  }
};
