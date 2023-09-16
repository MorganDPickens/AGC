// SPDX-License-Identifier: MIT
pragma solidity>= 0.8.0 < 0.9.0; 


contract A {
    address public a;
    uint public interval = 100; 
    function innerAddTen (uint _input) public pure returns (uint){
    
        
        return _input + 10;
    }



}

contract B is A {

    function outerAddTen(uint _any) public pure returns (uint) {
    return A.innerAddTen(_any) ;
    } 
     function innerval() public view returns (uint){
     return  A.interval; 
     }

}
