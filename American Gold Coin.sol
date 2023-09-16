// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol"; 
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract AmericanGoldCoin is ERC20, Ownable, Pausable {
         using SafeMath for uint256;
        uint256 public constant MAX_SUPPLY = 20000000000000000000000000; // 20,000,00 AGC
        uint256 public miningDifficulty = 1; // Inital mining difficulty
        uint256 public initialMiningReward = 1e12; // Inital mining reward: 0.000000000001 AGC
        uint256 public miningRewardHalvingInterval = 210000;
        uint256 public transferFee = 0; // Transfer fee in basis points (0.01% by default)
        mapping(address => uint256) private minedBalance; 
        mapping(address => uint256) private pendingWithdrawals;

        event Mined(address indexed miner, uint256 minedAmount);
        event TransferFeeUpdated(uint256 newFee);

        constructor() ERC20("American Gold Coin", "AGC") {
         _mint(msg.sender, MAX_SUPPLY); // Mint all tokens to the contract creator
        }

        //Mining function
        function mine() external whenNotPaused {
            require(minedBalance[msg.sender] < MAX_SUPPLY, "Max supply reached");
            uint256 minedAmount = initialMiningReward * miningDifficulty;
            minedBalance[msg.sender] = minedBalance[msg.sender].add(minedAmount);
            _mint(msg.sender, minedAmount);
            emit Mined(msg.sender, minedAmount);
            // Halve the mining reward after a certain number of blocks
            if (block.number % miningRewardHalvingInterval == 0 && miningDifficulty
            > 1) {
                miningDifficulty = miningDifficulty.div(2);
             
            
            }
        }
             
                      

        //Function to transfer mined tokens 
        function transferMined(address to, uint256 amount) external{
            require(minedBalance[msg.sender] >= amount, "Insufficient mined balance");
            minedBalance[msg.sender] = minedBalance[msg.sender].sub(amount);
            _transfer(msg.sender, to, amount);
             
        }
        
        // Buy Tokens function 
        function buyTokens(uint256 amount)external payable whenNotPaused {
            require(totalSupply().add(amount) <= MAX_SUPPLY, "Exceeds max supply");
            require(msg.value >= amount.mul (1e10), "Insufficient ETH sent");
            _mint(msg.sender, amount);
        }

        // ERC-20 standard approve and transferFrom functions for trading 
        function approve(address spender, uint256 amount) public override whenNotPaused returns (bool){
               _approve(msg.sender, spender, amount);
                     return true;
        }
        function transferFrom(address sender, address recipient, uint256 amount)
        public override whenNotPaused returns (bool) {
            uint256 feeAmount = amount.mul (transferFee).div(10000);
            uint256 netAmount = amount.sub(feeAmount);
            _transfer(sender, recipient, netAmount);
            _transfer (sender, owner(), feeAmount);
            _approve(sender, msg.sender, allowance( sender, msg.sender).sub(amount));
            return true;

        }

        // Withdraw ETH function for trading
        function withdraw() external whenNotPaused {
            uint256 amount = pendingWithdrawals[msg.sender];
            require (amount > 0, "No pending withdrawls");
            pendingWithdrawals[msg.sender] = 0;

        payable(msg.sender).transfer(amount);
        }
            

        // Deposit ETH function for trading 
        receive() external payable {
            pendingWithdrawals[msg.sender] = pendingWithdrawals[msg.sender].add(msg.value);
        }
        
        // Function to pause and unpause the contract
        function pause() external onlyOwner {
            _pause ();
        }

        function unpause() external onlyOwner {
            _unpause ();
        }
        
        // inital distribution function (can only be called by the owner)

        function initialDistribution(address[] calldata recipients, uint256[]
        calldata amounts) external onlyOwner {
            require(recipients.length == amounts.length,"Invalid input lengths");
            for (uint256 i = 0; i < recipients.length; i++) { 
                _transfer(msg.sender, recipients[i], amounts[i]);
            }
        }
        

        // Burn function to permanently remove tokens from circulation 
        // can onky be called by the owner 

        function burn(uint256 amount) external onlyOwner {
            _burn(msg.sender, amount);
        }
    // update the transfer fee (can only be called by the owner)
         function updateTransferFee(uint256 newFee) external onlyOwner {
             require(newFee <= 10000, "Fee exceeds 100%");
             transferFee = newFee;
             emit TransferFeeUpdated(newFee);
         }
}

