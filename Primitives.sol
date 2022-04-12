//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

import "./Enum.sol";

contract Primitives{

    bool public boo = true;

    uint8 public u8 = 1;

    uint public u256=423;

    uint public u = 123;

    int8 public i8= -1;

    int public i256 = 412;

    int public i = -123;

    int public minInt = type(int).min;
    int public maxInt = type(int).max;

    address public addr = 0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c;

    bytes1 a = 0x1b;



    string public text = "hello";
    uint public num  =1;

    address public constant MY_ADDRESS = "0x0b9f024272965b06116ac94344ef2c3419CeA757";
    uint public constant  MY_UINT = 123;

    address public immutable MY_IM_ADDERSS ;
    uint public immutable MY_IM_UINT ;

    constructor(uint _MyUint){
        MY_IM_ADDERSS = "0x0b9f024272965b06116ac94344ef2c3419CeA757";
        MY_IM_UINT = 123;
    }

    function get() public {
        uint i = 455;
        uint timestamp = block.timestamp;
        address sender = msg.sender;
    }


    Enum.Status public status ;
    uint public onewei = 1 wei;
    
}