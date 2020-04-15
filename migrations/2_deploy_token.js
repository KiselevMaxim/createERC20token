const EIP = artifacts.require('./EIP20.sol');

module.exports = async (deployer) => {
  await deployer.deploy(EIP, 1000000*10**18, "Smartphone Exposure Index", 18, 'SEI');

  console.log(`
    ---------------------------------------------------------------
    - Smartphone Exposure Index (SEI) TOKEN SUCCESSFULLY DEPLOYED -
    ---------------------------------------------------------------
    - Contract address: ${EIP.address}    
    ---------------------------------------------------------------
  `);
};