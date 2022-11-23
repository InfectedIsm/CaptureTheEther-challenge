pragma solidity ^0.4.21;

contract TestTheRandomNumberChallenge {
    uint8 answer;
    bool won;

    constructor() public {
        answer = uint8(keccak256(block.blockhash(block.number - 1), now));
        won = false;
    }

    function isComplete() external view returns (bool) {
        return won;
    }

    function getAnswer() external view returns (uint8) {
        return answer;
    }

    function computeHash(uint blockNumber, uint unixTimestamp) external view returns (uint8 computedHash) {
    computedHash = uint8(keccak256(block.blockhash(blockNumber-1), unixTimestamp));
        return computedHash;
    }

    function guess(uint8 n) external {
        if (n == answer) {
            won=true;
        }
    }
}