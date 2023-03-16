// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

//This is a factory contract that is meant to deploy any contract.
// function deploy keyword is used to achieve this.
//takes in the contract to be deplayed. made payable incase there's need to send ether when deploying.
// address of contract to be returned was contract is deployed, hence the returns in function declaration.

contract Proxy {
    event Deploy(address);

    fallback() external payable {}

    function deploy(
        bytes memory _code
    ) external payable returns (address addr) {
        assembly {
            // deploying an abitrary contract we use assembly. inside assembly we are going to use create(v, p, n).
            // v = amount of ETH ton send
            // p = pointer in memory to start of code
            // n = size of code
            addr := create(callvalue(), add(_code, 0x20), mload(_code))
        }
        require(addr != address(0), "deploy failed");
        emit Deploy(addr);
    }

    function execute(address _target, bytes memory _data) external payable {
        (bool success, ) = _target.call{value: msg.value}(_data);
        require(success, "failed");
    }
}
