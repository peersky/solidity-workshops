// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

struct UBIStorage {
    uint256 claimAmount; // 32 bytes
    address token; // 20 bytes
    mapping(address => bool) isVerified; //32 bytes
    mapping(address user => mapping(uint256 day => bool)) isClaimed; //32 bytes
    address verifier;
}

library LibUBI {
    /// @notice Storage slot for the diamond storage pattern using ERC-7201
    bytes32 private constant UBIStorageLocation =
        keccak256(abi.encode(uint256(keccak256("Simple.UBI.storage")) - 1)) &
            ~bytes32(uint256(0xff));

    function getStorage() internal pure returns (UBIStorage storage s) {
        bytes32 position = UBIStorageLocation;
        assembly {
            s.slot := position
        }
    }

    function isVerified(address _address) external view returns (bool) {
        return getStorage().isVerified[_address];
    }

    /**
     * @notice Calculates the current day based on the block timestamp.
     * @dev The day is calculated as `block.timestamp / 1 days`.
     * @return The current day number.
     */
    function currentDay() public view returns (uint256) {
        return block.timestamp / 1 days;
    }

    function isAuthorizedToClaim(
        UBIStorage storage s,
        address user
    ) internal returns (bool) {
        return s.isVerified[user] || s.isClaimed[user][currentDay()];
    }

    // fallback() external payable {
    //     require(msg.value > 0, "No funds sent");
    //     require(isVerified[msg.sender], "Not verified");
    //     payable(msg.sender).transfer(msg.value);
    // }
}
