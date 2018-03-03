pragma solidity ^0.4.17;

contract BetManager {
    
    address public creator;
    address[] public betEvents;
    uint public length;
    
    modifier onlyCreator() {
        if (msg.sender == creator) 
        _ ;
    }

    function BetManager() public {
        creator = msg.sender;
        length = 0;
    }
    
    function addEvent(address eventAddr) public onlyCreator {
        betEvents.push(eventAddr);
        length++;
    }

}
