//SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "./PriceConverter.sol";

error NotOwner();

contract FundMe{
    //indicate we can use methods of the library in uint types as paramters
    using PriceConverter for uint256; 

    //Constants spend less gas than variables
    uint256 public constant MINIMUN_USD = 50 * 1e18; 

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    //immutables named with i_ before the name of the variable by convention, 
    //immutables spend less gas than variables
    address public immutable i_owner; 

    constructor(){
        i_owner = msg.sender;
    }

    function fund() public payable{
        // 1e18 == 1 eth
        //require(msg.value > 1e18, "Didn't send enough"); // 1e18 == 1 * 10 ** 18 == 1000000000000000000 (value on wei of 1 eth)
        /*
            msg.value is the amount of ether on wallet who call the funtion
            msg.sender is the address of the wallet who call the funtion
        */

        //require(getConversionRate(msg.value) >= MINIMUN_USD, "Didn't send enough!");
        //msg.value.getConversionRate(); => using the library, is the same as getConversionRate(msg.value)
        require(msg.value.getConversionRate() >= MINIMUN_USD, "Didn't send enough!");

        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
    }

    function withdraw() public onlyOwner { 
        //restart mapping accounts
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }

        //restart array
        funders = new address[](0); //complete empty new array

        //withdraw the founds
        /*
            msg.sernder = address
            payable(msg.sender) = payable address
        */

        //transfrer
        //payable(msg.sender).transfer(address(this).balance); //23000 gas and throws error

        //send
        /*
        bool sendSuccess = payable(msg.sender).send(address(this).balance); //2300 gas and return bool
        require(sendSuccess, "Send failed"); //reverts all
        */
        
        //call (recomnended)
        (bool callSuccess,) = payable(msg.sender).call{value: address(this).balance}(""); //forward all gas or set gass, returns bool
        require(callSuccess, "Send failed"); //reverts all     
    }

    modifier onlyOwner{
        // _; // this represents the complete function that use the modifier, 
        //it can be before or after the requiere depending what we want to execute first
        
        /*
        require(msg.sender == i_owner, "Sender is not owner");
        */

        //for new versions of solidity (^0.8.4) can use custom errors
        //save gas, becose don't storage a string with the message
        if(msg.sender != i_owner) revert NotOwner();
        _;
    }

    receive() external payable{
       fund();
    }

    fallback() external payable{
        fund();
    }
}
