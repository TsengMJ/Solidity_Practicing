// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Wallet {
    event Received(address from, uint256 amount);
    event Withdraw(address from, uint256 amount);

    address payable public owner;

    modifier isOwner() {
        require(msg.sender == owner);
        _;
    }

    constructor() {
        owner = payable(msg.sender);
    }

    receive() external payable {
        emit Received(msg.sender, msg.value);
    }

    function withdraw(uint256 _amount) external isOwner {
        payable(msg.sender).transfer(_amount);
    }

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
