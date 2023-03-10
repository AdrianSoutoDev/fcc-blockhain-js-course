//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SimpleStorage.sol";

contract StorageFactory{

    SimpleStorage[] public simpleStorageArray;

    //with this function we can deploy smartcontracts from smart contracts
    function createSimpleStorageContract() public{
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageArray.push(simpleStorage);
    }

    function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public {
        //ABI - Application Binary Interface (is like a signs of the methos of one contract)
        //when we importing the contract, we are importing the ABI
        simpleStorageArray[_simpleStorageIndex].store(_simpleStorageNumber);
    }

    function sget(uint256 _simpleStorageIndex) public view returns(uint256){
        /*
            SimpleStorage simpleStorage =  simpleStorageArray[_simpleStorageIndex];
            return simpleStorage.retrieve();
        */

        return simpleStorageArray[_simpleStorageIndex].retrieve();
    }

}