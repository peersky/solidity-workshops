// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;
import {IVerifier} from "./IVerifier.sol";

abstract contract Verifier is IVerifier {
    mapping(address => bool) public _isVerified;
    mapping(address => uint256) public _validUntil;

    function getUser(
        address user
    ) public view returns (bool isVerified, uint256 validUntil) {
        return (_isVerified[user], _validUntil[user]);
    }

    function _verify(address user, bytes memory data) internal virtual {
        _isVerified[user] = true;
        _validUntil[user] = block.timestamp + 30 days;
    }
}
