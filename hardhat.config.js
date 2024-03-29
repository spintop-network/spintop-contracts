require("dotenv").config();
require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-etherscan");
require("hardhat-gas-reporter");
require("@nomiclabs/hardhat-ethers");
require("hardhat-tracer");

module.exports = {
  solidity: {
    version: "0.8.0",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
        // details: {
        //   yul: true,
        //   yulDetails: {
        //     stackAllocation: true,
        //     optimizerSteps: "dhfoDgvulfnTUtnIf",
        //   },
        // },
      },
    },
  },
  networks: {
    hardhat: {
      forking: {
        url: process.env.BINANCE_URL_PUBLIC || "",
        accounts: process.env.PRIVATE_KEY !== undefined ? [process.env.PRIVATE_KEY] : [],
      },
    },
    mainnet: {
      url: process.env.MAINNET_URL || "",
      accounts: process.env.PRIVATE_KEY !== undefined ? [process.env.PRIVATE_KEY] : [],
    },
    fantom: {
      url: process.env.FANTOM_URL || "",
      accounts: process.env.PRIVATE_KEY !== undefined ? [process.env.PRIVATE_KEY] : [],
    },
    binance: {
      url: process.env.BINANCE_URL_PUBLIC || "",
      accounts: process.env.PRIVATE_KEY !== undefined ? [process.env.PRIVATE_KEY] : [],
    },
    polygon: {
      url: process.env.POLYGON_URL || "",
      accounts: process.env.PRIVATE_KEY !== undefined ? [process.env.PRIVATE_KEY] : [],
    },
    okc: {
      url: process.env.OKC_URL || "",
      accounts: process.env.SPINTOP_DEPLOYER !== undefined ? [process.env.SPINTOP_DEPLOYER] : [],
    },
    devm: {
      url: process.env.DEVM_URL || "",
      accounts: process.env.MAC_KEY !== undefined ? [process.env.MAC_KEY] : [],
    },
  },
  etherscan: {
    apiKey: process.env.MAINNET_ETHERSCAN_KEY,
  },
  gasReporter: {
    enabled: false,
    currency: "USD",
    token: "BNB",
    gasPrice: 7,
    gasPriceApi: "https://api.bscscan.com/api?module=proxy&action=eth_gasPrice",
    coinmarketcap: process.env.COINMARKETCAP,
  },
  mocha: {
    timeout: 100000000,
  },
};
