// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

interface PriceFeedConsumer {
    function getPriceFeedAddress() external view returns (address);

    function getLatestPrice() external view returns (int256);
}
