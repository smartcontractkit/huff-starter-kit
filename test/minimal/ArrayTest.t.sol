// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "../../src/interfaces/ArrayPlay.sol";

contract ArrayPlayTest is Test {
    ArrayPlay public arrayPlay;

    function setUp() public {
        arrayPlay = ArrayPlay(
            HuffDeployer.config().deploy("minimal/ArrayPlay")
        );
    }

    function testGetArrayAtPositionZero() public {
        uint256 valToStore = 77;
        arrayPlay.storeInArray(valToStore);

        uint256 readValue = arrayPlay.readFromArray(0);
        assert(readValue == valToStore);
    }

    function testGetArrayAtPositionTwo() public {}
}
