// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract bank {
    address bank_owner;
    mapping (address => uint) accounts;

    constructor() {
        bank_owner = msg.sender;
    }

    function deposit() public payable {
        accounts[msg.sender] += msg.value; 
    }

    function withdraw(uint amount) public payable {
        require(accounts[msg.sender] >= amount, "Insufficient Funds");
        accounts[msg.sender] -= amount;
        (bool sent,) = msg.sender.call{value:amount}("sent");
        require(sent, "Failed to Complete");
    }

    function getBalance() public view returns (uint){
        return accounts[msg.sender];
    }
}
