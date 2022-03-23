var ShareWallet = artifacts.require('./ShareWallet.sol');

module.exports = function (deployer) {
  deployer.deploy(ShareWallet);
};
