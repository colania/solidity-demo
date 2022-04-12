//SPDX-License-Identifier:GPL-3.0
pragma solidity ^0.8.10;

contract Counter{
    uint public count;

    function get() public view returns(uint){
        return count;
    }

    function inc() public{
        count+= 1;
    }

    function dec() public{
        count -=1;
    }
}