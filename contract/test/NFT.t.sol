// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "openzeppelin-contracts/contracts/utils/Strings.sol";
import "../src/NFT.sol";

// FIXME: https://book.getfoundry.sh/tutorials/solidity-scripting を見ながら書いたコントラクトのテスト記述がわからない
contract ContractTest is Test {
    NFT public nftContract;

    // function setUp() public {
    //     nftContract = new NFT(
    //         "CreativeCert",
    //         "CC",
    //         "https://creativecert.web.app"
    //     );
    // }

    // function testMintTo() public {
    //     address user1 = address(1);
    //     address user2 = address(2);
    //     nftContract.mintTo(user1);
    //     uint256 tokenIndex1 = nftContract.currentTokenId();

    //     nftContract.mintTo(user2);
    //     uint256 tokenIndex2 = nftContract.currentTokenId();

    //     assertEq(tokenIndex1, 0);
    //     assertEq(tokenIndex2, 1);
    // }

    // function testTokenURI(uint256 index) public {
    //     string memory result = nftContract.tokenURI(index);
    //     string memory expected = string(
    //         abi.encodePacked(
    //             "https://creativecert.web.app/meta/",
    //             Strings.toString(index),
    //             ".json"
    //         )
    //     );

    //     assertEq(expected, result);
    // }
}
