// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Merkle tree - Древо Меркла

contract Tree {
    //      Hroot

    // H1-2     H3-4

    // H1   H2  H3  H4

    // TX1 TX2 TX3 TX4
    
    // "TX3: Misha -> Masha"
    // 0xc92ec56c84ee2b20cc1062fa605a91bbf5f7543486c74c17a458eb5a0cd70c9f TX3
    // index 2
    // 0x9b63578b51517c75092dc2d776cbd758adc189b8a0102a88447438f4cd5ae360 root
    // 0x3269085cca0d937e7f735926d6c663429b0e6098ce44623915739c2deb51cfe7 H1-2
    // 0x337d2648f225b05d328fea32b96ef475bad604dd28db4370689d05961542835c H4
    bytes32[] public hashes;
    string[4] transactions = [
        "TX1: Richard -> Markle",
        "TX2: Markle -> Richard",
        "TX3: Misha -> Masha",
        "TX4: Alice -> Bob"
    ];

    constructor() {
        for(uint i = 0; i < transactions.length; i++) {
            hashes.push(makeHash(transactions[i]));
        }

        uint count = transactions.length;
        uint offset = 0;

        while(count > 0) {
            for(uint i = 0; i < count - 1; i += 2) {
                hashes.push(keccak256(
                    abi.encodePacked(
                        hashes[offset + i], hashes[offset + i + 1]
                    )
                ));
            }
            offset += count;
            count = count / 2;
        }
    }

    function verify(string memory transaction, uint index, bytes32 root, bytes32[] memory proof) public pure returns(bool) {
        bytes32 hash = makeHash(transaction);
        for(uint i = 0; i < proof.length; i++) {
            bytes32 element = proof[i];
            if(index % 2 == 0) {
                hash = keccak256(abi.encodePacked(hash, element));
            } else {
                hash = keccak256(abi.encodePacked(element, hash));
            }
            index = index / 2;
        }
        return hash == root;
    }

    function encode(string memory input) public pure returns(bytes memory) {
        return abi.encodePacked(input);
    }

    function makeHash(string memory input) public pure returns(bytes32) {
        return keccak256(
            encode(input)
        );
    }
}