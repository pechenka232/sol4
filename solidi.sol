// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/proxy/Clones.sol";
import "./MyUpgradableContract.sol";

contract ContractFactory {
    address public implementation;

    constructor(address _implementation) {
        implementation = _implementation;
    }

    function createClone(uint256 _value) public returns (address) {
        address clone = Clones.clone(implementation);
        MyUpgradableContract(clone).initialize(_value);
        return clone;
    }
}
