// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract VaultVulnerable {
    mapping(address => uint256) public balances;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount);

        // Reentrancy
        (bool sent, ) = msg.sender.call{value: amount}("");
        require(sent);

        balances[msg.sender] -= amount;
    }

    // Missing access control
    function setOwner(address newOwner) external {
        owner = newOwner;
    }

    // Unchecked external call
    function unsafeCall(address target, bytes calldata data) external {
        target.call(data);
    }
}
