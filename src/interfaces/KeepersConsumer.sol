// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

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
