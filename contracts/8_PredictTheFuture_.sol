pragma solidity ^0.4.21;

contract PredictTheFutureChallenge {
    bool won;
    uint8 guess;
    uint256 settlementBlockNumber;
    
    function PredictTheFutureChallenge() public payable {}


    function isComplete() public view returns (bool) {
        return won;
    }


    function lockInGuess(uint8 n) public {
        guess = n;
        settlementBlockNumber = block.number + 1;
    }

    function settle() public returns (uint8) {
        require(block.number > settlementBlockNumber);

        uint8 answer = uint8(keccak256(block.blockhash(block.number - 1), now)) % 10;
        if (guess == answer) {
            won=true;
            msg.sender.transfer(address(this).balance);
        }
    return answer;
    }

    function returnHash() public view returns (uint8){
        return uint8(keccak256(block.blockhash(block.number - 1), now)) % 10;
    }

    function returnNow() public view returns (uint){
        return now;
    }

    function returnBlockNumberHash() public view returns (bytes32){
        return block.blockhash(block.number - 1);
    }

    function sendEtherToContract() public payable returns (bool) {
        uint balanceNow;
        require(msg.value > 0 );
        bool success = address(this).balance > balanceNow;
        return success;
    }

    function sendBalanceBack() public returns(bool){
        msg.sender.transfer(address(this).balance);
        if (address(this).balance == 0) {
            return true;
        }
        else
        {
            return false;
        }
    }

}