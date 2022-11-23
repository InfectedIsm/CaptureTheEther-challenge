pragma solidity ^0.4.21;

contract PredictTheBlockHashChallenge {
    address guesser;
    bytes32 guess;
    uint256 settlementBlockNumber;
    bool won;

    function PredictTheBlockHashChallenge() public payable {
    }

    function isComplete() public view returns (bool) {
        return won;
    }

    function lockInGuess(bytes32 hash) public payable {
        require(guesser == 0);

        guesser = msg.sender;
        guess = hash;
        settlementBlockNumber = block.number + 1;
    }

    function settle() public {
        require(msg.sender == guesser);
        require(block.number > settlementBlockNumber);

        bytes32 answer = block.blockhash(settlementBlockNumber);

        guesser = 0;
        if (guess == answer) {
            won = true;
        }
    }

    function returnBlockNumberHash(uint256 blockNumber) public view returns (bytes32){
        return block.blockhash(blockNumber);
    }    

}