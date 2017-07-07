var crowdfund = artifacts.require("./Crowdfund.sol");

module.exports = function(deployer) {
  deployer.deploy(crowdfund);
};
