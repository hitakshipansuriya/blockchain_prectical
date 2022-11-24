 // SPDX-License_Identifier; MIT

pragma solidity >=0.6.0 <0.9.0;
 
 import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";
 import "@chainlink/contracts/src/v0.6/vendor/SafeMathChainlink.sol";
 

    contract FundMe{

         using SafeMathChainlink for uint256;

         mapping(address => uint256) public addressToAmountfunded;
         address[] public funders;
          address public owner;

         constructor() public {
             owner = msg.sender;
         }

        function fund() public payable{

             uint256 minimumUSD = 50 * 10 * 18;
             require(getConversionRate(msg.value)  >=  minimumUSD, "you need to more ETH");
             addressToAmountfunded[msg.sender] += msg.value;
             funders.push(msg.sender);
             //what the ETH => USD conversion rate

        }

        function getversion() public view returns (uint256){

             AggregatorV3Interface pricefeed = AggregatorV3Interface(0x6D6D51e54641CDfC241c7B84F7b7AAa5e1F36b66);
            return pricefeed.version();

        }
           
        function getPrice() public view returns (uint256) {
             AggregatorV3Interface pricefeed = AggregatorV3Interface(0x6D6D51e54641CDfC241c7B84F7b7AAa5e1F36b66);
        (,int256 answer,,,)  = pricefeed.latestRoundData();
        return uint256(answer*10000000000);
    }

     function getConversionRate(uint256 ethAmount) public view returns (uint256){
          uint256 ethprice = getPrice();
          uint256 ethAmountinusd =(ethprice* ethAmount)/100000000000000000000;
          return ethAmountinusd;
     }

     modifier onlyOwner{
          require(msg.sender == owner);
          _;
     }

     function withdraw() payable onlyOwner public{
          //require(msg.sender == owner);
          msg.sender.transfer(address(this).balance);
          for(uint256 funderIndex=0; funderIndex < funders.length; funderIndex++){
               address funder = funders[funderIndex];
               addressToAmountfunded[funder] = 0;
          }
          funders = new address[](0);
     }
}

