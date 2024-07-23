require("dotenv").config();
require("@nomicfoundation/hardhat-toolbox");
require("@nomicfoundation/hardhat-verify");
require("hardhat-gas-reporter");
require("hardhat-tracer");
require("@nomicfoundation/hardhat-foundry");
require("@openzeppelin/hardhat-upgrades");
require("xdeployer");

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
        version: "0.8.20",
        settings: {
          optimizer: {
            enabled: true,
            runs: 200,
          },
        },
      },
      {
        version: "0.8.21",
        settings: {
          optimizer: {
            enabled: true,
            runs: 200,
          },
        },
      },
      {
        version: "0.8.23",
        settings: {
          optimizer: {
            enabled: true,
            runs: 200,
          },
        },
      },
      {
        version: "0.8.1",
      },
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
        url: process.env.RPC_URL || "",
        accounts:
          process.env.PRIVATE_KEY !== undefined
            ? [process.env.PRIVATE_KEY]
            : [],
      },
    },

    binance: {
      url: process.env.RPC_URL || "https://bsc-dataseed.binance.org/",
      accounts:
        process.env.PRIVATE_KEY !== undefined ? [process.env.PRIVATE_KEY] : [],
      gasPrice: 1000000000,
    },
    bsctestnet: {
      url:
        process.env.BSC_TESTNET_URL ||
        "https://data-seed-prebsc-1-s1.binance.org:8545/",
      accounts:
        process.env.PRIVATE_KEY !== undefined ? [process.env.PRIVATE_KEY] : [],
      gasPrice: 7000000000,
    },
    polygon: {
      url: process.env.POLYGON_URL || "https://rpc-mainnet.maticvigil.com/",
      accounts:
        process.env.PRIVATE_KEY !== undefined ? [process.env.PRIVATE_KEY] : [],
    },
    optimism: {
      url: "https://1rpc.io/op",
      accounts:
        process.env.PRIVATE_KEY !== undefined ? [process.env.PRIVATE_KEY] : [],
    },
  },
  xdeploy: {
    contract: "SwapRouter",
    constructorArgsPath: "./scripts/swapargs.js", // optional; default value is `undefined`
    salt: "SPINTOP",
    signer: process.env.PRIVATE_KEY,
    networks: ["polygon"],
    rpcUrls: ["https://polygon-rpc.com"],
    gasLimit: 2_500_000, // optional; default value is `1.5e6`
  },
  etherscan: {
    apiKey: {
      bsc: "FZ9HIYU2M91H29XAJ7G6MPTK3IYNDNUGET",
      polygon: "GVNSPADSK181BHEZH58I6XNGSC46TWM4D7",
      bscTestnet: "FZ9HIYU2M91H29XAJ7G6MPTK3IYNDNUGET",
      optimisticEthereum: "ZTAQ6XTRWG9BXCNPY5R284VH5CZAKPDEDV",
    },
  },
  sourcify: {
    // Disabled by default
    // Doesn't need an API key
    enabled: false,
  },
};
