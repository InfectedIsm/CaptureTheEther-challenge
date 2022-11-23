pragma solidity 0.4.21;

contract RetirementFundChallenge {
    uint256 startBalance;       // 1 ether = 10^18
    address owner = msg.sender; //msg.sender
    address beneficiary;        //msg.sender
    uint256 expiration = now + 10 years;    //1 year = 378432000
    

    function RetirementFundChallenge(address player) public payable {
        require(msg.value == 1 ether);

        beneficiary = player;       //msg.sender
        startBalance = msg.value;   // 1 ether = 10^18
    }

    function isComplete() public view returns (bool) {
        return address(this).balance == 0;
    }

    function withdraw() public {
        require(msg.sender == owner); //myself

        if (now < expiration) {
            // early withdrawal incurs a 10% penalty
            msg.sender.transfer(address(this).balance * 9 / 10);
        } else {
            msg.sender.transfer(address(this).balance);
        }
    }

    function collectPenalty() public {
        require(msg.sender == beneficiary);

        uint256 withdrawn = startBalance - address(this).balance; //underflow ==> 1 - 2 = 256^2 - 1

        // an early withdrawal occurred
        require(withdrawn > 0);

        // penalty is what's left
        msg.sender.transfer(address(this).balance);
    }

    function getNow() public view returns (uint256) {
        return now;
    }
}