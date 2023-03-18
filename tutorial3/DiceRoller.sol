//SPDX-License-Identifier: MIT
//Dice-roller => 5,6 -> we win
pragma solidity ^0.8.17;

contract DiceRoller{
    //enum - перечисление
    enum Dice{
        notStarted,
        one,
        two,
        three,
        four,
        five,
        six
    }

    constructor() payable {}

    Dice public dice;

    //logs
    event GamePlayed(address player, Dice diceRolled, bool isWinner);

                              //Play2Earn 
    function rollDice() public payable returns(bool, uint256) {
                                                    //encodePacked - несколько информаций включить и получить в байт
        uint256 _pseudoRandomNumber = block.timestamp%6+1;//uint256(keccak256(abi.encodePacked(block.difficulty, block.timestamp, block.gaslimit)))%6+1;
        //random = pseudo random
        //uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, players, counter)));
        //dice = _pseudoRandomNumber % 6+1;
        //emit GamePlayed(msg.sender, dice, false);

        if(_pseudoRandomNumber == 1) {
            dice = Dice.one;
            emit GamePlayed(msg.sender, dice, false);
        }
        else if(_pseudoRandomNumber == 2) {
            dice = Dice.two;
            emit GamePlayed(msg.sender, dice, false);
        }
        else if(_pseudoRandomNumber == 3) {
            dice = Dice.three;
            emit GamePlayed(msg.sender, dice, false);
        }
        else if(_pseudoRandomNumber == 4) {
            dice = Dice.four;
            emit GamePlayed(msg.sender, dice, false);
            payable(msg.sender).transfer(msg.value*2);
            return (true, _pseudoRandomNumber);
        }
        else if(_pseudoRandomNumber == 5) {
            dice = Dice.five;
            emit GamePlayed(msg.sender, dice, true);
            //payable(msg.sender).transfer(address(this).balance);
            payable(msg.sender).transfer(msg.value*2);
            return(true, _pseudoRandomNumber);
        }
        else if(_pseudoRandomNumber == 6) {
            dice = Dice.six;
            emit GamePlayed(msg.sender, dice, true);
            payable(msg.sender).transfer(msg.value*2);
            return (true, _pseudoRandomNumber);
        }
        return (false, _pseudoRandomNumber);
    }
    
    receive() external payable{}

}