// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/cryptography/EIP712.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "@openzeppelin/contracts/utils/Context.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/utils/Strings.sol";


contract MetaTransaction is EIP712 {
    using ECDSA for bytes32;
    using Address for address;

    string private constant SIGNING_DOMAIN = "MetaTransaction";
    string private constant SIGNATURE_VERSION = "1";

    mapping(address => uint256) private _nonces;

    constructor() EIP712(SIGNING_DOMAIN, SIGNATURE_VERSION) {}

    function getNonce(address account) public view returns (uint256) {
        return _nonces[account];
    }

    function _verify(
        address from,
        uint256 nonce,
        bytes memory signature
    ) internal view returns (bool) {
        bytes32 structHash = keccak256(abi.encode(
            keccak256("MetaTransaction(address from,uint256 nonce)"),
            from,
            nonce
        ));
        bytes32 hash = _hashTypedDataV4(structHash);
        return hash.toEthSignedMessageHash().recover(signature) == from;
    }

    function executeMetaTransaction(
        address from,
        uint256 nonce,
        bytes memory signature
    ) public {
        require(_verify(from, nonce, signature), "Invalid signature");
        _nonces[from]++;
        
    }
}
