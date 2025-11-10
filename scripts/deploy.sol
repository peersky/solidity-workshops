// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {DeployScript, DeployScriptRunner} from "forge-std/Script.sol";
import {MyContractV1} from "../src/MyContractV1.sol"; // Your initial contract
import {Upgrades} from "@openzeppelin/foundry-upgrades";

contract DeployScript is DeployScriptRunner {
    function run() external {
        // Deploy the proxy and initialize it
        address proxy = Upgrades.deployProxy(
            "SimpleUBI.sol",
            msg.sender,
            abi.encodeCall(MyContractV1.initialize, (10)) // Example initialization
        );

        console.log("MyContractV1 deployed to:", proxy);
    }
}
