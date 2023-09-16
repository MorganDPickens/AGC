// SPDX-License-Identifier: MIT
pragma solidity>= 0.7.0 < 0.9.0;

contract arrayKing {

uint [] public changeArray;


function removeElement(uint i) public {
         changeArray[i] = changeArray [changeArray.length -1];
         changeArray.pop ();


}
function test() public {
     changeArray.push (1);
     changeArray.push (2);
     changeArray.push (3);
     changeArray.push (4);
}


 function pop() public {
      changeArray.pop();
 }

 function push(uint number) public {
      changeArray.push(number);
 }
function getLength() public view returns (uint){
         return changeArray.length;
         

}
function getChangeArray () public view returns (uint[] memory){
     return changeArray;
     
}
}