// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract CodeConversationContract {
    string public generatedCode;
    address public owner;

    constructor() { owner = msg.sender ;}

    modifier onlyOwner(){
        require(msg.sender == owner);
        _;

    
}
function requestedCodeGeneration(string memory question) public {
    generatedCode = generateCodeFromQuestion (question);
}

function getCode () public view returns (string memory) {
    return generatedCode; 
}
function generateCodeFromQuestion(string memory question) internal pure returns (string memory) {
    return question; }
}