/*
 * @source: https://capturetheether.com/challenges/math/token-sale/
 * @author: Steve Marx
 */

pragma solidity ^0.4.21;

contract TokenSaleChallenge {
    mapping(address => uint256) public balanceOf;
    uint256 constant PRICE_PER_TOKEN = 1 ether;

    function TokenSaleChallenge(address _player) public payable {
        require(msg.value == 1 ether);
    }

    function isComplete() public view returns (bool) {
        return address(this).balance < 1 ether;
    }

    function buy(uint256 numTokens) public payable {
        //ruleid: swe-101
        require(msg.value == numTokens * PRICE_PER_TOKEN);

        //ruleid: swe-101
        balanceOf[msg.sender] += numTokens;
    }

    function sell(uint256 numTokens) public {
        require(balanceOf[msg.sender] >= numTokens);

        //ok: swe-101
        balanceOf[msg.sender] -= numTokens;
        //ruleid: swe-101
        msg.sender.transfer(numTokens * PRICE_PER_TOKEN);
    }
}
