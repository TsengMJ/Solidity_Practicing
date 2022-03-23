const Arcane = artifacts.require('Arcane');

module.exports = function (deployer) {
  deployer.deploy(Arcane, 1000000);
};
