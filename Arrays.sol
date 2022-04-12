pragma solidity =0.8.13;
 
contract Arrays{
    uint[] public arr;
    
    function get(uint _i) public view returns (uint){
        return arr[_i];
    }

    function push(uint _i) public {
        arr.push(_i);
    }

    function move(uint _i) public{
        delete arr[_i];
    }
}