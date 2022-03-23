// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract SharedWallet {
    event DepositFunds(address from, uint256 amount);
    event WithdrawFunds(address from, uint256 amount);
    event TransferFunds(address from, address to, uint256 amount);

    address private _owner;

    mapping(address => bool) private _permitOwners;

    modifier isOwner() {
        require(msg.sender == _owner);
        _;
    }

    modifier validOwner() {
        require(msg.sender == _owner || _permitOwners[msg.sender]);
        _;
    }

    constructor() {
        _owner = msg.sender;
    }

    function addPermitOwner(address permitOwner) public isOwner {
        _permitOwners[permitOwner] = true;
    }

    function removeOwner(address permitOwner) public isOwner {
        _permitOwners[permitOwner] = false;
    }

    function deposit() external payable {
        emit DepositFunds(msg.sender, msg.value);
    }

    function withdraw(uint256 amount) public validOwner {
        require(address(this).balance >= amount);
        payable(msg.sender).transfer(amount);
        emit WithdrawFunds(msg.sender, amount);
    }
}
