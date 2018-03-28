pragma solidity ^0.4.17;

import "../installed_contracts/oraclize-api/contracts/usingOraclize.sol";

contract BetManager {
    address[] public betEvents;
    uint public length;
    function addEvent(address eventAddr) public {
        betEvents.push(eventAddr);
        length++;
    }
}

contract Betting is usingOraclize, BetManager {
    
    struct Bet {
        address addr;
        uint outcomeIndex;
        uint256 amount;
        uint256 winnings;
        bool paid;
    }

    modifier onlyCreator() {
        if (msg.sender == creator) 
        _;
    }

    address public creator;
    
    string public outcomeOne;
    string public outcomeTwo;
    string public outcomeThree;
    string public jsonIndex;
    string public fid;
    
    uint public state;
    uint public teamOneScore;
    uint public teamTwoScore;
    uint public winningIndex;
    uint private bettingIndex;

    uint256 public kickOffTime;
    uint256[] public totalPools;
    
    mapping(address => uint) public bettingIndices;
    mapping(uint => Bet) public bets;
    
    function Betting(string _outcomeOne, string _outcomeTwo, string _outcomeThree, uint256 _kickOffTime, string _jsonIndex, string _fid, address managerAddress) public {
        creator = msg.sender;
        outcomeOne = _outcomeOne;
        outcomeTwo = _outcomeTwo;
        outcomeThree = _outcomeThree;
        kickOffTime = _kickOffTime;
        jsonIndex = _jsonIndex;
        fid = _fid;
        totalPools = new uint256[](4);
        winningIndex = 5;
        bettingIndex = 1;
        state = 0;
        BetManager betManager = BetManager(managerAddress);
        betManager.addEvent(this);
    }
    
    function placeBet(uint _outcomeIndex) public payable {
        require(state == 0);
        uint index = bettingIndex++;
        bettingIndices[msg.sender] = index;
        bets[index] = Bet({addr: msg.sender, outcomeIndex: _outcomeIndex, amount: msg.value, paid: false, winnings: 0});
        totalPools[_outcomeIndex] += msg.value;
        totalPools[3] += msg.value;
    }
    
    function changeBet(uint _outcomeIndex) public {
        require(state == 0 && bettingIndices[msg.sender] != 0);
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
        require(state == 3);
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
