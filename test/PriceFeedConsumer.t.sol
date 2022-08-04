// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "./mocks/MockV3Aggregator.sol";
import "../src/interfaces/PriceFeedConsumer.sol";

contract PriceFeedConsumerTest is Test {
    uint8 public constant DECIMALS = 18;
    int256 public constant INITIAL_ANSWER = 1 * 10**18;
    PriceFeedConsumer public priceFeedConsumer;
    MockV3Aggregator public mockV3Aggregator;

    function setUp() public {
        mockV3Aggregator = new MockV3Aggregator(DECIMALS, INITIAL_ANSWER);
        priceFeedConsumer = PriceFeedConsumer(
            HuffDeployer
                .config()
                .with_addr_constant(
                    "PRICE_FEED_ADDRESS",
                    address(mockV3Aggregator)
                )
                .deploy("PriceFeedConsumer")
        );
    }

    function testSetUp() public {
        address priceFeedAddress = priceFeedConsumer.getPriceFeedAddress();
        console.log(priceFeedAddress);
        assert(priceFeedAddress == address(mockV3Aggregator));
    }

    function testReadValue() public {
        int256 priceFromHuff = priceFeedConsumer.getLatestPrice();
        assertTrue(priceFromHuff == INITIAL_ANSWER);
    }
}
