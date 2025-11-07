// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

struct UBIStorage {
    uint256 clamAmount; // 32 bytes
    address token;      // 20 bytes
    mapping(address => bool) isVerified; //32 bytes
    mapping(address user => mapping(uint256 day => bool)) isClaimed; //32 bytes

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

    function isAuthorizedToClaim(UBIStorage storage s, address user) internal {
        return s.isVerified[user] || ;
    }

    // fallback() external payable {
    //     require(msg.value > 0, "No funds sent");
    //     require(isVerified[msg.sender], "Not verified");
    //     payable(msg.sender).transfer(msg.value);
    // }
}
