pragma solidity ^0.8.10;

contract A{

    function foo() public pure virtual returns(string memory){
        return "A";
    }


}

contract B is A{
    function foo() public pure virtual override returns(string memory){
        return "B";
    }
}


contract C is A{
    function foo() public pure virtual override returns(string memory){
        return "C";
    }
}


// return B
contract D is C,B{
    function foo() public pure override(C,B) returns(string memory){
        return super.foo();
    }
}


//return c 
contract E is B,C{
    function foo() public pure override(B,C) return(string memory){
        return super.foo();
    }
}


// Inheritance must be ordered from “most base-like” to “most derived”.
// Swapping the order of A and B will throw a compilation error.
contract F is A,B{
    function foo() public pure override(A,B) return(string memory){
        return super.foo();
    }
}