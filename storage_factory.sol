// SPDX-License_Identifier; MIT

pragma solidity ^0.6.0;

import "./simple.sol";

contract storage_factory is simple{

        simple[] public simpleStorageArray;

    function createsimplestoragecontract() public {
        simple simpleStorage = new simple();
        simpleStorageArray.push(simpleStorage);
        }

    function sfstore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public {

        //Address
        //ABI(appliction binary interface)
        simple simpleStorage = simple(address(simpleStorageArray[_simpleStorageIndex]));
        simpleStorage.store(_simpleStorageNumber);
    }

    function sfGet(uint256 _simpleStorageIndex) public view returns (uint256){
        simple simpleStorage= simple(address(simpleStorageArray[_simpleStorageIndex]));
         return simpleStorage.retrieve();
    }

    
}