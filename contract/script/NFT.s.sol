// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/NFT.sol";

contract ContractScript is Script {
    function setUp() public {}

    function run() public {
        vm.broadcast();

        NFT nft = new NFT("CreativeCert", "CC", "https://creativecert.web.app");

        vm.stopBroadcast();
    }
}
