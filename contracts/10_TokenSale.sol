///SPDX-License-Identifier: UNLICENSED

pragma solidity 0.4.21;

contract TokenSaleChallenge {
    mapping(address => uint256) public balanceOf;
    uint256 constant PRICE_PER_TOKEN = 1 ether;

    function TokenSaleChallenge() public payable {
        require(msg.value == 1 ether);
    }

    function isComplete() public view returns (bool) {
        return address(this).balance < 1 ether;
    }

    function buy(uint256 numTokens) public payable {
        require(msg.value == numTokens * PRICE_PER_TOKEN);
        balanceOf[msg.sender] += numTokens;
    }

    function sell(uint256 numTokens) public {
        require(balanceOf[msg.sender] >= numTokens);

        balanceOf[msg.sender] -= numTokens;
        msg.sender.transfer(numTokens * PRICE_PER_TOKEN);
    }

    function msgSenderAddr() public view returns(address) {
        return msg.sender;
    }

    function getThisBalance() public view returns (uint){
        return address(this).balance;
    }

    function multiply(uint256 a) public pure returns (uint256) {
        return a * PRICE_PER_TOKEN;
    }

    function receive() external payable {}

}