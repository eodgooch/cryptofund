pragma solidity ^0.4.11;

contract Crowdfund {

  // cryptofund account
  struct Account {
    address uuid;
  }

  // campaign funder
  struct Funder {
    uint uuid;
    uint amount;
    address wallet;
  }

  // campaign
  struct Campaign {
	  address beneficiary; // benefactor of the campaign
    uint fundingGoal; // end goal
	  uint numFunders; // number of funders to the campaign
	  uint amount; // current amount backing campaign
    uint endDate; // ending date time in seconds from epoch
    bool isActive; // is the campaign active
    mapping (address => Funder) funders;
  }

  // utils
  address cryptofund;
  uint numCampaigns = 0;
  mapping (uint => Campaign) campaigns;

  // functionality
  // newCampaign starts a new cryptofund
  function newCampaign(address beneficiary, uint fundingGoal, uint endDate) returns (uint campaignID) {
	  campaignID = numCampaigns++; // campaignID is return variable
	  // Creates new struct and saves in storage. We leave out the mapping type.
	  campaigns[campaignID] = Campaign(beneficiary, fundingGoal, 0, 0, endDate, true);
  }

  // contribute to the campaign
  function contribute(uint campaignID) {
      Campaign c = campaigns[campaignID];
      if (c.isActive) {
      // if this is a new funder, create funder and assign to mapping
        if (c.funders[msg.sender]) {
          c.numFunders++;
          c.funders[msg.sender].push(Funder({uuid: msg.sender, amount: msg.value}));
          c.amount += msg.value;
      } else {
        // otherwise update the funders total contribution
        Funder updatedFunder = c.funders[msg.sender];
        updatedFunder.amount = updatedFunder.amount + msg.value;
        c.funders[msg.sender] = updatedFunder;
      }
    }
  }

  // remove the campaign (mark it unactive)
//  function deleteCampaign(uint campaignID) {
//    Campaign c = campaigns[campaignID];
//    c.isActive = false;
//    this.applyRefund(c);
//    //cryptofund.send(msg.gas);
//  }

  // todo
  // would like to provide a percentage based return policy
//  function applyRefund(Campaign campaign) {
//  }

  // has the campaign reached it's goal?
//	function checkGoalReached(uint campaignID) returns (bool reached) {
//    Campaign c = campaigns[campaignID];
//    return c.amount >= c.fundingGoal;
//	}

  // payout the beneficiary
//  function payout(Campaign compaignID) payable {
//    Campaign c = campaigns[campaignID];
//    if (this.checkGoalReached(campaignID)) {
//      c.beneficiary.transfer(c.amount);
//    } else {
//      this.applyRefund(c);
//    }
//    this.deleteCampaign(campaignID);
//    //cryptofund.send(msg.gas);
//  }

//  function fee(Campaign campaignID) payable {
//    Campaign c = campaigns[campaignID];
//    c.beneficiary.send(campaignID.fundingGoal / 100); //1% fee
//    //cryptofund.send(msg.gas);
//  }

}
