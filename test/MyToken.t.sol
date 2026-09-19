// SPDX-License-Identifier: MIT
pragma solidity 0.8.36;

import "forge-std/Test.sol";
import "../src/MyToken.sol";

contract MyTokenTest is Test {
    MyToken public token;

    function setUp() public {
        token = new MyToken();
    }

    function test_OwnerIsSet() public {
        assertEq(token.owner(), address(this));
    }
}
