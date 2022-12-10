// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Snacker.sol";
import "../src/TestMinter.sol";

interface CheatCodes {
    function prank(address, address) external;

    // Sets the *next* call's msg.sender to be the input address, and the tx.origin to be the second input
    function prank(address) external;

    // Sets the *next* call's msg.sender to be the input address
    function assume(bool) external;

    // When fuzzing, generate new inputs if conditional not met
    function deal(address who, uint256 newBalance) external;
    // Sets an address' balance
}


contract SnackerTest is Test {
    CheatCodes cheats = CheatCodes(HEVM_ADDRESS);
    Snacker public snacker;
    TestMinter public testMinterA;
    TestMinter public testMinterB;

    function setUp() public {
        snacker = new Snacker();
        testMinterA = new TestMinter();
        testMinterB = new TestMinter();

        cheats.prank(address(1));
        cheats.deal(address(1), 2 ether);
        testMinterA.mintNFT(address(1));
        testMinterB.mintNFT(address(1));
        emit log_address(address(snacker));
        emit log_address(address(testMinterA));
        emit log_address(address(testMinterB));
        
    }

    function testNftInitialization() public {
        assertEq(testMinterA.balanceOf(address(1)), 1);
        assertEq(testMinterB.balanceOf(address(1)), 1);
    }

    function testSnack() public {
        cheats.prank(address(1));
        testMinterA.approve(address(snacker), 1);
        cheats.prank(address(1));
        testMinterB.approve(address(snacker), 1);
        cheats.prank(address(1));
        snacker.Snack(address(testMinterA), 1, address(testMinterB), 1, address(1));
        assertEq(testMinterA.balanceOf(address(1)), 0);
        assertEq(testMinterB.balanceOf(address(1)), 0);
        assertEq(testMinterA.balanceOf(snacker.burn()), 1);
        assertEq(testMinterB.balanceOf(snacker.burn()), 1);
        assertEq(snacker.balanceOf(address(1)), 1);
    } 

    // function testSetNumber(uint256 x) public {
    //     counter.setNumber(x);
    //     assertEq(counter.number(), x);
    // }
}
