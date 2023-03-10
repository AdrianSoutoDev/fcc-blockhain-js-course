//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract FallbackExample{
    uint256 public result;

    //use this for somebody send ether to contract address but not calling any function
    receive() external payable{
       result = 1; 
    }

    //use this for somebody send ether to contract address but not calling any function and send data
    fallback() external payable{
        result = 2; 
    }
}