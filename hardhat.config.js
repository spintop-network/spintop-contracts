require("dotenv").config();
require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-etherscan");
require("hardhat-gas-reporter");
require("@nomiclabs/hardhat-ethers");
require("hardhat-tracer");

module.exports = {
  solidity: {
    compilers: [
      {
        version: "0.8.0",
        settings: {
          optimizer: {
            enabled: true,
            runs: 200,
          },
        },
      },
      {
        version: "0.8.15",
        settings: {
          optimizer: {
            enabled: true,
            runs: 200,
          },
        },
      },
      {
        version: "0.8.1",
      }
    ],
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
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

    binance: {
      url: "https://bsc-dataseed.binance.org/",
      accounts: ["0xfa13873866cddc26f3796d490ddf2cb5bd25392cef820f18ef19b87addd5815c"],
      gasPrice: 3000000000,
    },
    polygon: {
      url: process.env.POLYGON_URL || "",
      accounts: process.env.PRIVATE_KEY !== undefined ? [process.env.PRIVATE_KEY] : [],
    },
  },
  etherscan: {
    apiKey: "QH3QDHPBQ65XU2D98M3I6DNXK35BV6AWDJ"
  },



};
