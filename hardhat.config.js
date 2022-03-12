require("dotenv").config();
require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-etherscan");
require("hardhat-gas-reporter");

module.exports = {
  solidity: {
    compilers: [{ version: "0.8.2" }, { version: "0.8.4" }],
  },
  networks: {
    hardhat: {
      forking: {
        url: process.env.BINANCE_URL,
        accounts:
          process.env.PRIVATE_KEY !== undefined
            ? [process.env.PRIVATE_KEY]
            : [],
      },
    },
    fantom: {
      url: process.env.FANTOM_URL || "",
      accounts:
        process.env.PRIVATE_KEY !== undefined ? [process.env.PRIVATE_KEY] : [],
    },
    binance: {
      url: process.env.BINANCE_URL || "",
      accounts:
        process.env.PRIVATE_KEY !== undefined ? [process.env.PRIVATE_KEY] : [],
    },
    polygon: {
      url: process.env.POLYGON_URL || "",
      accounts:
        process.env.SPINTOP_DEPLOYER !== undefined
          ? [process.env.SPINTOP_DEPLOYER]
          : [],
    },
  },
  etherscan: {
    apiKey: process.env.BINANCE_ETHERSCAN_KEY,
  },
  gasReporter: {
    currency: "USD",
    gasPrice: 7,
  },
};
