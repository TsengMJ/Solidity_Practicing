var MultiSigWallet = artifacts.require('./MultiSigWallet.sol');

module.exports = function (deployer) {
  deployer.deploy(
    MultiSigWallet,
    [
      '0xab615befbda93f2711ecca4a1b2fb515f3d69214',
      '0xaa535e1f6499c19955feb84a7e779a18c1886470',
      '0x802444947c9c468c751e07a786daa572646f7803',
    ],
    2
  );
};
