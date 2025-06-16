// SPDX-License-Identifier: MIT

pragma solidity ^0.8.3;

contract SendEtherContract {
    receive() external payable {}

    function sendXandSendEther(TestContract _address, uint _x, uint _amount) external {
        _address.setXandReceiveEther{ value: _amount }(_x);
    }
}

contract CallTestContract {
    function setX(TestContract _test, uint _x) external {
        _test.setX(_x);
    }

    function getX(address _test) external view returns (uint x) {
        x = TestContract(_test).getX();
    }
}

contract TestContract {
    uint public x;
    uint public value = 123;

    function setX(uint _x) public {
        x = _x;
    }

    function getX() public view returns (uint) {
        return x;
    }

    function setXandReceiveEther(uint _x) external payable {
        x = _x;
        value = msg.value;
    }

    function getXandValue() external view returns (uint, uint) {
        return (x, value);
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}