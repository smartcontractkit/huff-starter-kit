// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

interface ArrayPlay {
    function readFromArray(uint256) external view returns (uint256);

    function storeInArray(uint256) external;
}
