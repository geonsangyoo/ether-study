// SPDX-License-Identifier: MIT
pragma solidity ^0.8.36;

contract MyToken {
    string private name = "Mainnet Token";
    address public owner;

    constructor() {
        owner = msg.sender;
    }
}
