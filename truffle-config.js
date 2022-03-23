const path = require('path');

module.exports = {
  // See <http://truffleframework.com/docs/advanced/configuration>
  // to customize your Truffle configuration!
  contracts_build_directory: path.join(__dirname, 'client/src/contracts'),

  compilers: {
    solc: {
      version: '^0.8.10',
    },
  },

  dashboard: {
    port: 24012,
  },

  networks: {
    develop: {
      port: 8545,
    },
  },
};