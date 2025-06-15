// SPDX-License-Identifier: MIT

pragma solidity ^0.8.3;

contract FallbackOnly {
    event Log(string value);
    fallback() external payable {
        emit Log("Fallback called");
    }
}
