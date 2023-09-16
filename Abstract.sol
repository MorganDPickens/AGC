// SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0; 



contract X {
    function y() public view virtual returns (string memory){}



}



contract Z is X {

function y() public override pure returns (string memory) {
        return 'hello'; 
}
}




contract Member {
string name;
uint age= 38;

function setname() public  virtual returns (string memory){}
function returnAge() public view returns(uint) {
    return age;
}
}


contract Teacher is Member {
      function setname() public pure override returns(string memory) {
          return 'Gordan'; 
      }

}


abstract contract Calculator {
 function returnInt (uint x, uint y)public pure virtual returns (uint);

}


contract Test is Calculator {

    function returnInt (uint x, uint y) public pure override returns(uint) {
    return x + y;

    }



}