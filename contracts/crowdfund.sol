pragma solidity ^0.4.0;

contract crowdfund {

  // cryptofund account 
  struct Account {
    address public uuid;
  }

  // campaign funder 
	struct Funder {	
		address public uuid;
    int amount; 
	}

  // campaign 
  struct Campaign {
		string name; // campaign name
		address beneficiary; // benefactor of the campaign
		uint fundingGoal; // end goal
		uint numFunders; // number of funders to the campaign
		uint amount; // current amount backing campaign 
    uint endDate; // ending date time in seconds from epoch
    bool isActive; // is the campaign active
		mapping (addr => Funder) funders;
  }
 
  // utils
	address cryptofund;
  uint numCampaigns;
	mapping (uint => Campaign) campaigns;

  // functionality 
	// newCampaign starts a new cryptofund 
  function newCampaign(string name, address beneficiary, uint fundingGoal, uint endDate) returns (uint campaignID) {
		campaignID = numCampaigns++; // campaignID is return variable
		// Creates new struct and saves in storage. We leave out the mapping type.
		campaigns[campaignID] = Campaign(name, beneficiary, fundingGoal, 0, 0, endDate, true);
	  cryptofund.send(msg.gas);
  }

  // contribute to the campaign
	function contribute(uint campaignID) payable {
		Campaign c = campaigns[campaignID];
      if (c.isActive) {
        // if this is a new funder, create funder and assign to mapping
        if (bytes(funders[msg.sender]).length != 0) {
          c.numFunders++;
          c.funders[msg.sender] = Funder(uuid: msg.sender, amount: msg.value});
          c.amount += msg.value;
        } else {
          // otherwise update the funders total contribution 
          updatedFunder = c.funders[msg.sender];
          updatedFunder.amount = updatedFunder.amount + msg.value;
          c.funders[msg.sender] = updatedFunder;
        }
    }
    cryptofund.send(msg.gas);
	}

  // remove the campaign (mark it unactive)
  function deleteCampaign(uint campaignID) payable {
    Campaign c = campaigns[campaignID];
    c.isActive = false;
    this.applyRefund(c);
    cryptofund.send(msg.gas);
  }
  
  // todo 
  // would like to provide a percentage based return policy
  function applyRefund(Campaign campaign) {
    
  }

  // has the campaign reached it's goal?
	function checkGoalReached(uint campaignID) returns (bool reached) {
    Campaign c = campaigns[campaignID];
    return c.amount >= c.fundingGoal;
	} 

  // payout the beneficiary
  function payout(Campaign compaignID) {
    Campaign c = campaigns[campaignID];
    if (this.checkGoalReached(campaignID)) {
      c.beneficiary.transfer(c.amount);
    } else {
      this.applyRefund(c);
    }
    this.deleteCampaign(campaignID);
    cryptofund.send(msg.gas);
  }

  function fee(Campaign campaignID){
    Campaign c = campaigns[campaignID];
    c.beneficiary.send(campaignID.fundingGoal / 100); //1% fee
    cryptofund.send(msg.gas);
  }

}
