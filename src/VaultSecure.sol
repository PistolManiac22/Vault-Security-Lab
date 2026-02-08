// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract VaultSecure {
    mapping(address => uint256) public balances;
    address public owner;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount);

        balances[msg.sender] -= amount;

        (bool sent, ) = msg.sender.call{value: amount}("");
        require(sent);
    }

    function setOwner(address newOwner) external onlyOwner {
        owner = newOwner;
    }

    function safeCall(address target, bytes calldata data) external onlyOwner {
        (bool ok, ) = target.call(data);
        require(ok);
    }
}
