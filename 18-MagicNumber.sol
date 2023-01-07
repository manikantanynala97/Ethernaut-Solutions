// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
// https://goerli.etherscan.io/address/0xd2e5e0102e55a5234379dd796b8c641cd5996efd

contract MagicNum {

  address public solver;

  constructor() {}

  function setSolver(address _solver) public {
    solver = _solver;
  }

  /*
    ____________/\\\_______/\\\\\\\\\_____        
     __________/\\\\\_____/\\\///////\\\___       
      ________/\\\/\\\____\///______\//\\\__      
       ______/\\\/\/\\\______________/\\\/___     
        ____/\\\/__\/\\\___________/\\\//_____    
         __/\\\\\\\\\\\\\\\\_____/\\\//________   
          _\///////////\\\//____/\\\/___________  
           ___________\/\\\_____/\\\\\\\\\\\\\\\_ 
            ___________\///_____\///////////////__
  */

contract MagicNumberAttack
{
  /*
     1) bytecode = '600a600c600039600a6000f3602a60505260206050f3'
     2) txn = await web3.eth.sendTransaction({from: player, data: bytecode})
     3) solverAddr = txn.contractAddress
     4) await contract.setSolver(solverAddr)
  */
}
