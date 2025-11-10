// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

interface IVerifier {
    function getUser(
        address user
    ) external view returns (bool isVerified, uint256 validUntil);

    function verify(address user, bytes memory data) external;
}
