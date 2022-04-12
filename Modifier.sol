pragma solidity ^0.8.10;

contract Modifier{

    address public owner;
    uint public x =10;
    bool public locked;

    constructor(){
        owner = msg.sender;
    }
    modifier onlyOwner()  {
        require(msg.sender== owner,"not yet ");
        _;
    }

    function changeOwner(address _newOwner) public onlyOwner{
        owner = _newOwner;
    }
}