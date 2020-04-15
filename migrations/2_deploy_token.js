const EIP20 = artifacts.require('./EIP20.sol');

module.exports = async (deployer) => {
  await deployer.deploy(EIP20, process.env.TOKEN_SUPPLY*10**18, process.env.TOKEN_NAME, 18, process.env.TOKEN_SYMBOL);

  console.log(`
    ---------------------------------------------------------------
    - ${process.env.TOKEN_NAME} (${process.env.TOKEN_SYMBOL}) TOKEN SUCCESSFULLY DEPLOYED -    
    -
    - TOKEN SUPPLY = ${process.env.TOKEN_SUPPLY*10**18} -
    ---------------------------------------------------------------
    - Contract address: ${EIP20.address}    
    ---------------------------------------------------------------
  `);
};