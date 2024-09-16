// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/AccessControl.sol";

contract AccessControlled is AccessControl {
    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");
    bytes32 public constant USER_ROLE = keccak256("USER_ROLE");

    constructor() {
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _setupRole(ADMIN_ROLE, msg.sender);
    }

    function grantUserRole(address account) public onlyRole(ADMIN_ROLE) {
        grantRole(USER_ROLE, account);
    }

    function revokeUserRole(address account) public onlyRole(ADMIN_ROLE) {
        revokeRole(USER_ROLE, account);
    }

    function hasUserRole(address account) public view returns (bool) {
        return hasRole(USER_ROLE, account);
    }
}
