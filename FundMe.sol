
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

             uint256 mimimumUSD = 50 * 10 * 18; 
             //1gwei < $50
             require(getConversionRate(msg.value) >= mimimumUSD, "You need to spend more ETH!");
             addressToAmountfunded[msg.sender] += msg.value;
             //what the ETH => USD conversion rate
             funders.push(msg.sender);

        }

        function getversion() public view returns (uint256){

             AggregatorV3Interface pricefeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
            return pricefeed.version();

        }
           
        function getPrice() public view returns (uint256) {
             AggregatorV3Interface pricefeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        (,int256 answer,,,)  = pricefeed.latestRoundData();
        return uint256(answer*10000000000);
    }

     function getConversionRate(uint256 ethAmount) public view returns (uint256){
          uint256 ethprice = getPrice();
          uint256 ethAmountinusd =(ethprice* ethAmount)/100000000000000000000;
          return ethAmountinusd;
     }

     modifier onlyOwner {
          require(msg.sender == owner);
          _;
     }

     function withdraw() payable onlyOwner public{
       
          msg.sender.transfer(address(this).balance);
          for (uint256 funderIndex=0; funderIndex < funders.length; funderIndex++){
               address funder = funders[funderIndex];
               addressToAmountfunded[funder] = 0;
          }
          funders = new address[](0);
     }
}