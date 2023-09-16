// SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0; 

contract Withdrawl {

address public OnlyOwner;
address public tatiana; 
mapping (address => uint256 ) public balances; 

event Sent(  address from, address to, uint256);

constructor () {

OnlyOwner = msg.sender;
}

modifier onlyOwner {
require (msg.sender == OnlyOwner); 
_;
}
function setTatianaAddress( address _tatiana) public onlyOwner {
    tatiana = _tatiana;
}

function SendOnlyMe(uint256 amount)  public onlyOwner{
    require (tatiana !=address (0), "Amount must be greater then 0");
    require (amount > 0, "Amount must be greater than 0");
    (bool sent,) = tatiana.call{value: amount}("");
    require(sent, "Failed to send funds to tatiana");
    emit Sent (msg.sender,tatiana, amount);


}

function depositFunds() public payable {
    require(msg.value > 0, "Amount must be greater then 0");
    balances[ msg.sender] += msg.value; 
}

function claimRefund() public {
    require(balances[ msg.sender] > 0, "no balance avaiable for refund");
    (bool sent,) = payable(msg.sender).call{value: balances[msg.sender]}("");
    require(sent, "Failed to send the refund"); balances[msg.sender]= 0; 


}
function withDrawFunds (uint amount) public payable  returns ( bool success) {
    require(balances[msg.sender] >= amount); 
    balances[msg.sender] -= amount; 
    msg.sender.transfer(amount);
    return true; 

}

}