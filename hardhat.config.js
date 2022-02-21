require("dotenv").config();
require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-etherscan");

module.exports = {
  solidity: {
    compilers: [{ version: "0.8.2" }, { version: "0.8.4" }],
  },
  networks: {
    hardhat: {
      forking: {
        url: process.env.BINANCE_URL,
        accounts:
          process.env.SPINTOP_DEPLOYER !== undefined
            ? [process.env.SPINTOP_DEPLOYER]
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
        process.env.SPINTOP_DEPLOYER !== undefined
          ? [process.env.SPINTOP_DEPLOYER]
          : [],
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
    apiKey: process.env.POLYGON_ETHERSCAN_KEY,
  },
};
