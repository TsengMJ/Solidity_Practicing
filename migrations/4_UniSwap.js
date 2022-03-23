var UniSwap = artifacts.require('./UniSwap.sol');

module.exports = function (deployer) {
  deployer.deploy(UniSwap);
};
