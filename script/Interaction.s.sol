// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract BasicNftMint is Script {
    string public constant PUG =
        "ipns://k51qzi5uqu5dk1w5rz2blbfp91842pxj6pzf9tqjr3kl8d25xe6wh1fhtkf8zz/";

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "BasicNft",
            block.chainid
        );
        mintNftOnContract(mostRecentlyDeployed);
    }

    function mintNftOnContract(address mostRecentlyDeployed) public {
        vm.startBroadcast();
        BasicNft(mostRecentlyDeployed).mintNft(PUG);
        vm.stopBroadcast();
    }
}
