//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SafeMathTester{
    uint8 public bigNumber = 255;

    function add() public{
        //unchecked{bigNumber = bigNumber + 1;} //don't check is overflow or underflow: 255 + 1 = 0
        bigNumber = bigNumber + 1; //new versions of solidity like 0.8 check over an under flows by defect
    }
}