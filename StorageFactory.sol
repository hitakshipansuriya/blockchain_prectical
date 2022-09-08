// SPDX-License-Identfier: MIT

pragma solidity ^0.6.0;

import "./Simple.sol";

contract StorageFactory {

    Simple[] public SimpleArray;

    function createSipleStorageContract() public {
        Simple simple  = new Simple();
        SimpleArray.push(simple);

    }

    function sfStore(uint256 _simpleIndex, uint256 _simpleNumber) public {
        //Addredd
        //ABI         
        Simple(address(SimpleArray[_simpleIndex])).store(_simpleNumber);
    }

    function sfGet(uint256 _simpleIndex) public view returns (uint256) {
        return Simple(address(SimpleArray[_simpleIndex])).retrieve();
    }
}
