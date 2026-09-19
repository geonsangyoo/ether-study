// SPDX-License-Identifier: MIT
pragma solidity 0.8.36;

import "forge-std/Script.sol";
import "../src/MyToken.sol";

contract MyTokenScript is Script {
    function run() external {
        MyToken token;
        // Start broadcasting transactions to the network
        vm.startBroadcast();
        token = new MyToken();
        // Stop broadcasting transactions to the network
        vm.stopBroadcast();

        console.log("MyToken deployed at:", address(token));
    }
}
