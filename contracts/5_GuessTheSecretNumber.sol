///SPDX-License-Identifier: UNLICENSED
pragma solidity  ^0.4.21;

contract FindHash {

    bytes32 hash = 0xdb81b4d58595fbbbb592d3661a34cdca14d7ab379441400cbfa1b78bc447c365;

    constructor () public {}

    function searchHash() external view returns (uint8 n) {
 
        for (n=0; n<256; n++) {
            if (keccak256(abi.encodePacked(n)) == hash) {
                return n;
            }
        }
    }

    function computeHash(uint blockNumber, uint timestamp) external pure returns (uint8 computedHash) {
        computedHash = uint8(keccak256(blockNumber-1, timestamp));
        return computedHash;
    }
}

