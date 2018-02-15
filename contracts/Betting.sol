pragma solidity ^0.4.17;

contract Betting {
  address public creator;

  uint public testCounter;  

  modifier onlyCreator() {
    if (msg.sender == creator) 
    _ ;
  }

  function Betting() public {
    creator = msg.sender;
    testCounter = 0;
  }

  function placeBet(uint outcomeIndex) public payable {
      testCounter++;
  }

  function changeBet(uint outcomeIndex) public payable {
      testCounter++;
  }

  function eventOver() private onlyCreator {
      testCounter++;
  }

  function claimWinnings() public {
      testCounter++;
  }

}
