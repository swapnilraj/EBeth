pragma solidity ^0.4.17;

import "../installed_contracts/oraclize-api/contracts/usingOraclize.sol";

contract Betting is usingOraclize {
    
    address public creator;
    
    string public outcomeOne;
    string public outcomeTwo;
    string public outcomeThree;
    uint256 public kickOffTime;
    
    uint256[] public totalPools;
    uint256 public winningIndex;
    
    uint public state;

    string public jsonIndex;
    uint public teamOneScore;
    uint public teamTwoScore;

    struct Bet {
        address addr;
        uint outcomeIndex;
        uint256 amount;
        uint256 winnings;
        bool paid;
    }
    
    mapping(address => uint) public bettingIndices;
  
    modifier onlyCreator() {
        if (msg.sender == creator) 
        _ ;
    }

    Bet[] public bets;

    uint private bettingIndex;

    function Betting(string _outcomeOne, string _outcomeTwo, string _outcomeThree, uint256 _kickOffTime, string _jsonIndex) public {
        creator = msg.sender;
        outcomeOne = _outcomeOne;
        outcomeTwo = _outcomeTwo;
        outcomeThree = _outcomeThree;
        kickOffTime = _kickOffTime;
        jsonIndex = _jsonIndex;
        totalPools = new uint256[](4);
        winningIndex = 5;
        bettingIndex = 1;
        state = 0;
    }
    
    function placeBet(uint _outcomeIndex) public payable {
        require(state==0);
        bettingIndices[msg.sender] = bettingIndex++;
        bets[bettingIndices[msg.sender]] = Bet({addr: msg.sender, outcomeIndex: _outcomeIndex, amount: msg.value, paid: false, winnings: 0});
        totalPools[_outcomeIndex] += msg.value;
        totalPools[3] += msg.value;
    }
    
    function changeBet(uint _outcomeIndex) public {
        require(state==0 && bettingIndices[msg.sender]!=0);
        Bet storage previousBet = bets[bettingIndices[msg.sender]];  
        totalPools[previousBet.outcomeIndex] -= previousBet.amount;
        totalPools[_outcomeIndex] += previousBet.amount;
        previousBet.outcomeIndex = _outcomeIndex;
        bets[bettingIndices[msg.sender]] = previousBet;
    }

    function eventStarted() public onlyCreator {
        state = 1;
    }

    function __callback(bytes32 myid, string result, bytes proof) public {
        if (msg.sender != oraclize_cbAddress()) revert();
        if(state == 2){
            teamOneScore = parseInt(result);
            state = 3;
            queryAwayScore();
        }else if(state == 3){
            teamTwoScore = parseInt(result);
            if(teamOneScore>teamTwoScore){
                winningIndex = 0;
            }
            else if(teamOneScore<teamTwoScore){
                winningIndex = 2;
            }else{
                winningIndex = 1;
            }
            sendWinnings();
        }
    }

    function eventOver() public payable onlyCreator {
        state = 2;
        queryHomeScore();
    }

    function queryHomeScore() private {
        oraclize_query("URL",   strConcat("json(http://fplalerts.com/api/fpl_lhs_17.php).scores.",jsonIndex,".h_sc"));
    }

    function queryAwayScore() private {
        oraclize_query("URL",   strConcat("json(http://fplalerts.com/api/fpl_lhs_17.php).scores.",jsonIndex,".a_sc"));
    }

    function sendWinnings() private {
        require(state ==3);
        for(uint i = 1; i<bettingIndex;i++){
            Bet storage placedBet = bets[i];
            if((placedBet.outcomeIndex == winningIndex) && (placedBet.paid == false)){
                placedBet.winnings = placedBet.amount+((((totalPools[3]-totalPools[winningIndex])*(placedBet.amount/totalPools[winningIndex]))*(100-5))/100);
                placedBet.paid = true;
                bets[i] = placedBet;
                placedBet.addr.transfer(placedBet.winnings);
            }
        }
    }

}
