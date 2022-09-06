// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "../src/interfaces/KeepersConsumer.sol";

contract KeepersConsumerTest is Test {
    KeepersConsumer public keepersConsumer;
    uint256 public staticTime;
    uint256 public interval;
    uint256 public afterInterval;

    function setUp() public {
        staticTime = block.timestamp;
        interval = 60;
        afterInterval = block.timestamp + 60 + 1;
        // string memory hexSixty = "0x000000000000000000000000000000000000003c";
        // we need the string hex of 60 which is: 0x3c
        // cast to-hex 60
        keepersConsumer = KeepersConsumer(
            HuffDeployer.config().with_constant("INTERVAL", "0x3c").deploy(
                "KeepersConsumer"
            )
        );
        vm.warp(staticTime);
    }

    function testCheckIntervalSetup() public {
        uint256 keepersInterval = keepersConsumer.interval();
        assertTrue(keepersInterval == interval);
    }

    function testCheckupReturnsFalseBeforeTime() public {
        (bool upkeepNeeded, ) = keepersConsumer.checkUpkeep("0x");
        assertTrue(!upkeepNeeded);
    }

    function testCheckupReturnsTrueAfterTime() public {
        vm.warp(afterInterval); // Needs to be more than the interval
        (bool upkeepNeeded, ) = keepersConsumer.checkUpkeep("0x");
        assertTrue(upkeepNeeded);
        assertTrue(upkeepNeeded);
    }

    function testPerformUpkeepUpdatesTime() public {
        // Arrange
        uint256 currentCounter = keepersConsumer.counter();
        vm.warp(afterInterval); // Needs to be more than the interval

        // Act
        keepersConsumer.performUpkeep("0x");

        // Assert
        assertTrue(keepersConsumer.lastTimeStamp() == block.timestamp);
        assertTrue(currentCounter + 1 == keepersConsumer.counter());
    }
}
