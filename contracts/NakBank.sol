// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract NakBank {
    mapping(address => uint) private balances;
    address public owner;

    event Deposit(address indexed user, uint amount);
    event Withdrawal(address indexed user, uint amount);

    constructor() {
        owner = msg.sender;
    }

    function deposit() public payable {
        require(msg.value > 0, "Deposit amount must be greater than zero.");
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(uint amount) public {
        require(amount <= balances[msg.sender], "Insufficient balance.");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        emit Withdrawal(msg.sender, amount);
    }

    function getBalance(address user) public view returns (uint) {
        return balances[user];
    }
}
