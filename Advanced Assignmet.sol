// SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0;

interface UniswapV2Factory {
    function getPair(address tokenA, address tokenB ) external view returns
    (address pair); 
}

interface UniswapV2pair {
    function getReserve() external view returns (uint112 reserve0, uint112 reserve1, uint32
    blockTimesStampLast);
}
contract Track1 { 
    address private USDT = 0xdAC17F958D2ee523a2206206994597C13D831ec7;
    address private USDC =0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48; 
    address private factory = 0x5c69beE701Ef814A2B6a3edd481652cB9cc5aA6F; 
    



 function getReserveTokens() external view returns(uint, uint) {
     address pair = UniswapV2Factory(factory).getPair(USDC,USDT); 
     (uint reserve0, uint reserve1,) = UniswapV2pair(pair).getReserve();
     return (reserve0, reserve1); 
 }
 }
