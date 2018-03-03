pragma solidity ^0.4.17;

contract Betting {
    
    address public creator;
    
    string public outcomeOne;
    string public outcomeTwo;
    string public outcomeThree;
    uint256 public kickOffTime;
    
    uint256[] public totalPools;
    uint256 public winningIndex;
    
    uint public state;

    struct Bet {
        uint outcomeIndex;
        uint256 amount;
        bool paid;
    }
    
    mapping(address => Bet) public bets;
  
    modifier onlyCreator() {
        if (msg.sender == creator) 
        _ ;
    }

    function Betting(string _outcomeOne, string _outcomeTwo, string _outcomeThree, uint256 _kickOffTime) public {
        creator = msg.sender;
        outcomeOne = _outcomeOne;
        outcomeTwo = _outcomeTwo;
        outcomeThree = _outcomeThree;
        kickOffTime = _kickOffTime;
        totalPools = new uint256[](4);
        winningIndex = 5;
        state = 0;
    }
    
    function placeBet(uint _outcomeIndex) public payable {
        require(state==0);
        bets[msg.sender] = Bet({outcomeIndex: _outcomeIndex, amount: msg.value, paid: false});
        totalPools[_outcomeIndex] += msg.value;
        totalPools[3] += msg.value;
    }
    
    function changeBet(uint _outcomeIndex) public {
        require(state==0);
        Bet storage previousBet = bets[msg.sender];  
        totalPools[previousBet.outcomeIndex] -= previousBet.amount;
        totalPools[_outcomeIndex] += previousBet.amount;
        previousBet.outcomeIndex = _outcomeIndex;
        bets[msg.sender] = previousBet;
    }

    function eventStarted() public onlyCreator {
        state = 1;
    }

    function eventOver(uint _outcomeIndex) public onlyCreator {
        //todo Use Oraclize to get result from API
        winningIndex = _outcomeIndex;
        state = 2;
    }

    function claimWinnings() public {
        Bet storage placedBet = bets[msg.sender];
        require( placedBet.outcomeIndex == winningIndex);
        uint256 winnings = placedBet.amount+((((totalPools[3]-totalPools[winningIndex])*(placedBet.amount/totalPools[winningIndex]))*(100-1))/100);
        require( placedBet.paid == false);
        placedBet.paid = true;
        bets[msg.sender] = placedBet;
        msg.sender.transfer(winnings);
    }

}
