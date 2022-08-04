// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "forge-std/Script.sol";
import "./HelperConfig.sol";
import "../src/interfaces/KeepersConsumer.sol";
import "foundry-huff/HuffDeployer.sol";

contract DeployKeepersCounter is Script, HelperConfig {
    function run() external {
        HelperConfig helperConfig = new HelperConfig();

        // We are just hard coding 60 as 0x3c for now
        // (, , , , uint256 updateInterval, , , , ) = helperConfig
        //     .activeNetworkConfig();

        vm.startBroadcast();

        KeepersConsumer(
            HuffDeployer.config().with_constant("INTERVAL", "0x3c").deploy(
                "KeepersConsumer"
            )
        );

        vm.stopBroadcast();
    }
}
