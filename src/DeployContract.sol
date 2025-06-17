// SPDX-License-Identifier: MIT

pragma solidity ^0.8.3;

contract TestContract1 {
    address public owner = msg.sender;

    function setOwner(address _owner) public {
        require(msg.sender == owner, "not owner");
        owner = _owner;
    }
}

contract TestContract2 {
    address public owner = msg.sender;
    uint public value = msg.value;
    uint public x;
    uint public y;

    constructor(uint _x, uint _y) payable {
        x = _x;
        y = _y;
    }
}

contract Proxy {
    function deploy1() external payable {
        new TestContract1();
    }

    function deploy2() external payable returns (address) {
        return address(new TestContract2(1, 2));
    }
}

contract Proxy2 {
    event Deploy(address);

    function deploy(bytes memory _code) external payable returns (address) {
        address addr;

        assembly {
            // create (v, p, n)
            // v = amount of ether
            // p = pointer to start of code
            // n = length of code
            addr := create(
                callvalue(), // amount of ether because msg.value doesn't work.
                add(_code, 0x20), // 0x20 = 32 in hexadecimal because it just is.
                mload(_code) // lsize of code can be found using mload(_code)
            )
        }

        require(addr != address(0), "can't deploy to zero address.");

        emit Deploy(addr);
        return addr;
    }

    receive() external payable {}

    function execute(address _target, bytes memory _data) external payable {
        (bool success, ) = _target.call{value: msg.value}(_data);
        require(success, "failed");
    }
}

contract DeployHelper {

}