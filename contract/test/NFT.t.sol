// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "openzeppelin-contracts/contracts/utils/Strings.sol";
import "../src/NFT.sol";

contract Receiver is ERC721TokenReceiver {
    function onERC721Received(
        address operator,
        address from,
        uint256 id,
        bytes calldata data
    ) external override returns (bytes4) {
        return this.onERC721Received.selector;
    }
}

contract ContractTest is Test {
    using stdStorage for StdStorage;

    NFT private nft;

    function setUp() public {
        nft = new NFT("CreativeCert", "CC", "https://creativecert.web.app");
    }

    function testMintPricePaid() public {
        nft.mintTo{value: 0.01 ether}(address(1));
    }

    function testFailMaxSupplyReaches() public {
        uint256 slot = stdstore
            .target(address(nft))
            .sig("currentTokenId()")
            .find();
        bytes32 loc = bytes32(slot);
        bytes32 mockedCurrentTokenId = bytes32(abi.encode(10));
        vm.store(address(nft), loc, mockedCurrentTokenId);
        nft.mintTo{value: 0.01 ether}(address(1));
    }

    function testFailMintToZeroAddress() public {
        nft.mintTo{value: 0.01 ether}(address(0));
    }

    function testNewMintOwnerRegisterd() public {
        nft.mintTo{value: 0.01 ether}(address(1));
        uint256 slotOfNewOwner = stdstore
            .target(address(nft))
            .sig(nft.ownerOf.selector)
            .with_key(1)
            .find();

        uint160 ownerOfTokenIdOne = uint160(
            uint256(
                (vm.load(address(nft), bytes32(abi.encode(slotOfNewOwner))))
            )
        );

        assertEq(address(ownerOfTokenIdOne), address(1));
    }

    function testFailUnSafeContractReceiver() public {
        vm.etch(address(1), bytes("mock code"));
        nft.mintTo{value: 0.08 ether}(address(1));
    }

    function testWithdrawalWorksAsOwner() public {
        // Mint an NFT, sending eth to the contract
        Receiver receiver = new Receiver();
        address payable payee = payable(address(0x1337));
        uint256 priorPayeeBalance = payee.balance;
        nft.mintTo{value: nft.MINT_PRICE()}(address(receiver));
        // Check that the balance of the contract is correct
        assertEq(address(nft).balance, nft.MINT_PRICE());
        uint256 nftBalance = address(nft).balance;
        // Withdraw the balance and assert it was transferred
        nft.withdrawPayments(payee);
        assertEq(payee.balance, priorPayeeBalance + nftBalance);
    }

    function testWithdrawalFailsAsNotOwner() public {
        // Mint an NFT, sending eth to the contract
        Receiver receiver = new Receiver();
        nft.mintTo{value: nft.MINT_PRICE()}(address(receiver));
        // Check that the balance of the contract is correct
        assertEq(address(nft).balance, nft.MINT_PRICE());
        // Confirm that a non-owner cannot withdraw
        vm.expectRevert("Ownable: caller is not the owner");
        vm.startPrank(address(0xd3ad));
        nft.withdrawPayments(payable(address(0xd3ad)));
        vm.stopPrank();
    }

    function testTokenURI() public {
        nft.mintTo{value: 0.01 ether}(address(1));
        string memory expected = string(
            abi.encodePacked(
                "https://creativecert.web.app/meta/",
                Strings.toString(nft.currentTokenId()),
                ".json"
            )
        );

        assertEq(expected, "https://creativecert.web.app/meta/1.json");
    }
}
