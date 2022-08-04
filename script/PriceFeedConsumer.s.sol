// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "forge-std/Script.sol";
import "./HelperConfig.sol";
import "../test/mocks/MockV3Aggregator.sol";
import "foundry-huff/HuffDeployer.sol";

contract DeployPriceFeedConsumer is Script, HelperConfig {
    uint8 constant DECIMALS = 18;
    int256 constant INITIAL_ANSWER = 2000e18;

    function run() external {
        HelperConfig helperConfig = new HelperConfig();

        (, , , , , address priceFeed, , , ) = helperConfig
            .activeNetworkConfig();

        if (priceFeed == address(0)) {
            priceFeed = address(new MockV3Aggregator(DECIMALS, INITIAL_ANSWER));
        }

        vm.startBroadcast();

        PriceFeedConsumer(
            HuffDeployer
                .config()
                .with_addr_constant("PRICE_FEED_ADDRESS", address(priceFeed))
                .deploy("PriceFeedConsumer")
        );

        vm.stopBroadcast();
    }
}

interface PriceFeedConsumer {}
