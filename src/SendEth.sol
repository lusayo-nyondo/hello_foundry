// SPDX-License-Identifier: MIT

pragma solidity ^0.8.3;

contract SendEther {
    constructor() payable {

    }

    function sendViaTransfer(address payable _to) external payable {
        _to.transfer(123);
    }

    function sendViaSend(address payable _to) external payable {
        bool sent = _to.send(123);
        require(sent, "send failed");
    }

    function sendViaCall(address payable _to) external payable {
        (bool sent, ) = _to.call{value: 123}("");
        require (sent, "Call failed");
    }

    receive() external payable {}
}

contract EthReceiver {
    constructor () payable {}

    receive() external payable {}

    function getBalance() external payable returns (uint){
        return address(this).balance;
    }
}