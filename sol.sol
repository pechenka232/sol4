// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract MyUpgradableContract is Initializable, UUPSUpgradeable {
    uint256 public value;

    function initialize(uint256 _value) public initializer {
        value = _value;
    }

    function _authorizeUpgrade(address newImplementation) internal override onlyRole(DEFAULT_ADMIN_ROLE) {}

    function setValue(uint256 _value) public {
        value = _value;
    }
}
