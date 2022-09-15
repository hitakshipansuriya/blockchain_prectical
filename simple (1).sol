//SPDX-License-Identifier; MET

 pragma solidity ^0.6.0;

contract simple{

    uint256  public favoriteNumber;
   // bool favoritebool=false;
   // string favoritestring="string";
   // int256 favoriteInt=6;
   // bytes32 favoritbytes="cat";

   struct People{
       uint256  favoriteNumber;
       string name;
   }

    People[]  public person;
    mapping(string => uint256) public nameToFavoriteNumber;

    function store(uint256 _favoriteNumber)public{
        favoriteNumber = _favoriteNumber;
    }

   function retrieve() public view returns(uint256)
   {
       return favoriteNumber;
   }

   // people public person=people({favoriteNumber : 1 ,name:"abc"});
    
    function addperson(string memory _name,uint256 _favoriteNumber) public {
        person.push(People(_favoriteNumber,_name));
        nameToFavoriteNumber[_name]= _favoriteNumber;
    }
   
}