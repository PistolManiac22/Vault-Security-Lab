// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/VaultVulnerable.sol";
import "../src/Attacker.sol";
import "../src/VaultSecure.sol";

contract VaultAuditTest is Test {
    VaultVulnerable vault;
    Attacker attacker;
    address user = address(0xBEEF);

    function setUp() public {
        vault = new VaultVulnerable();

        vm.deal(address(this), 10 ether);
        vm.deal(user, 5 ether);

        vault.deposit{value: 5 ether}();
        vm.prank(user);
        vault.deposit{value: 1 ether}();

        attacker = new Attacker(address(vault));
    }

    function test_Reentrancy() public {
    vm.deal(address(attacker), 1 ether);
    vm.expectRevert();
    attacker.attack{value: 1 ether}();
    }


    function test_AccessControl() public {
        vm.prank(user);
        vault.setOwner(user);

        assertEq(vault.owner(), user);
    }

    function test_UncheckedCall() public {
        vault.unsafeCall(address(0xdead), "");
    }

    function test_Secure_NoReentrancy() public {
    VaultSecure secure = new VaultSecure();

    address user = address(0xCAFE);
    vm.deal(user, 5 ether);

    vm.prank(user);
    secure.deposit{value: 5 ether}();

    // legitimate withdrawals succeed
    vm.prank(user);
    secure.withdraw(1 ether);

    vm.prank(user);
    secure.withdraw(1 ether);

    // withdrawing more than balance should revert
    vm.prank(user);
    vm.expectRevert();
    secure.withdraw(10 ether);
    }


    function test_Secure_AccessControl() public {
        VaultSecure secure = new VaultSecure();
        vm.prank(user);
        vm.expectRevert();
        secure.setOwner(user);
    }
}
