// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "./utils/Cheats.sol";

contract KeepersConsumerTest is Test {
    KeepersConsumer public keepersConsumer;
    uint256 public staticTime;
    uint256 public interval;
    Cheats internal constant cheats = Cheats(HEVM_ADDRESS);

    function setUp() public {
        staticTime = block.timestamp;
        interval = 60;
        // string memory hexSixty = "0x000000000000000000000000000000000000003c";
        // we need the string hex of 60 which is: 0x3c
        // cast to-hex 60
        keepersConsumer = KeepersConsumer(
            HuffDeployer.config().with_constant("INTERVAL", "0x3c").deploy(
                "KeepersConsumer"
            )
        );
        cheats.warp(staticTime);
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
        cheats.warp(staticTime + interval + 1); // Needs to be more than the interval
        (bool upkeepNeeded, ) = keepersConsumer.checkUpkeep("0x");
        assertTrue(upkeepNeeded);
        assertTrue(upkeepNeeded);
    }

    function testPerformUpkeepUpdatesTime() public {
        // Arrange
        uint256 currentCounter = keepersConsumer.counter();
        cheats.warp(staticTime + interval + 1); // Needs to be more than the interval

        // Act
        keepersConsumer.performUpkeep("0x");

        // Assert
        assertTrue(keepersConsumer.lastTimeStamp() == block.timestamp);
        assertTrue(currentCounter + 1 == keepersConsumer.counter());
    }
}

interface KeepersConsumer {
    function counter() external view returns (uint256);

    function interval() external view returns (uint256);

    function lastTimeStamp() external view returns (uint256);

    function checkUpkeep(bytes memory)
        external
        view
        returns (bool, bytes memory);

    function performUpkeep(bytes memory) external;
}