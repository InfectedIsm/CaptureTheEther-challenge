pragma solidity ^0.4.21;

contract TestTheNewNumberChallenge {
    bool won;       

    constructor() public {
    }

    function isComplete() public view returns (bool) {
        return won;
    }

    function resetState() public returns (bool) {
        won = false;
        return !won;
    }

    function guess(uint8 n) public returns (bool){
        uint8 answer = uint8(keccak256(block.blockhash(block.number - 1), now));
        if (n == answer) {
            won = true;
        }
        return won;
    }

    function getAnswer() public view returns (uint8) {
        return uint8(keccak256(block.blockhash(block.number - 1), now));
    }
}