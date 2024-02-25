// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {DeployBasicNft} from "../script/DeployBasicNft.s.sol";

contract BasicNftTest is Test {
    DeployBasicNft public deployBasicNft;
    BasicNft public basicNft;
    address public USER = makeAddr("user");
    string public constant PUG =
        "ipfs://QmNf1UsmdGaMbpatQ6toXSkzDpizaGmC9zfunCyoz1enD5/penguin/3987.png";

    function setUp() public {
        deployBasicNft = new DeployBasicNft();
        basicNft = deployBasicNft.run();
    }

    function testNameIsCorrect() public view {
        string memory expectName = "Gato";
        string memory actuallName = basicNft.name();

        //assert(expectName == actuallName);

        assert(
            keccak256(abi.encodePacked(expectName)) ==
                keccak256(abi.encodePacked(actuallName))
        );
    }

    function testCanMintAndHaveBalance() public {
        vm.prank(USER);
        basicNft.mintNft(PUG);

        assert(basicNft.balanceOf(USER) == 1);
        assert(
            keccak256(abi.encodePacked(PUG)) ==
                keccak256(abi.encodePacked(basicNft.tokenURI(0)))
        );
    }
}
