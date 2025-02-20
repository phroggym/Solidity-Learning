// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Op {
    // uint demo = 1;
    // uint128 a = 1;
    // uint128 b = 1;
    // uint256 c = 1;

    // bytes32 public hash = 0x9c22ff5f21f0b81b113e63f7db6da94fedef11b2119b4088b89664fb9a3cb658;

    // mapping(address => uint) payments;
    // function pay() external payable {
    //     require(msg.sender != address(0), "zero address");
    //     payments[msg.sender] = msg.value;
    // }

    // uint8[] demo = [1,2,3];

    uint public result = 1;
    function doWork(uint[] memory data) public {
        uint temp = 1;
        for(uint i = 0; i < data.length; i++) {
            temp *= data[i];
        }
        result = temp;
    }
}

contract Un {
    // uint8 demo = 1;
    // uint128 a = 1;
    // uint256 c = 1;
    // uint128 b = 1;

    // bytes32 public hash = keccak256(
    //     abi.encodePacked("test")
    // );

    // mapping(address => uint) payments;
    // function pay() external payable {
    //     address _from = msg.sender;
    //     require(_from != address(0), "zero address");
    //     payments[_from] = msg.value;
    // }

    // uint[] demo = [1,2,3];

    uint public result = 1;
    function doWork(uint[] memory data) public {
        for(uint i = 0; i < data.length; i++) {
            result *= data[i];
        }
    }
}