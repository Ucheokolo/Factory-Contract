// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import {TestContract1} from "./contract1.sol";

contract helper {
    function getBytecode1() external pure returns (bytes memory) {
        bytes memory bytecode = type(TestContract1).creationCode;
        return bytecode;
    }
}
