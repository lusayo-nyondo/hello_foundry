// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Counter {
    uint256 public number;

    event Log(string mesage, uint256 value);

    function setNumber(uint256 newNumber) public {
        number = newNumber;
        emit Log("Set number to: ", newNumber);
    }

    function increment() public {
        number++;
    }
}
