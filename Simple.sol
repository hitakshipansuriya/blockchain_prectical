//SPDX-License-Identifier: MIT


pragma solidity ^0.6.0;

contract Simple {

    //this will be get initialized by 0
    uint256 public favortiteNumber;
    bool favortitebool;

    struct People{
      uint256 favortiteNumber;
        string name;
    }
    People[] public people;
    mapping(string => uint256)public nametofavoriteNumber;

    function store(uint256 _favoriteNumber)public{
        favortiteNumber = _favoriteNumber;
    }
    function retrieve() public view returns(uint256){
        return favortiteNumber;
    }
    function addPerson(string memory _name,uint256 _favoriteNumber) public{
        people.push(People(_favoriteNumber,_name));
        nametofavoriteNumber[_name]= _favoriteNumber;

    }
}

