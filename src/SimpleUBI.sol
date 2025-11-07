// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;
import {LibUBI} from "./LibUBI.sol";
import {IUBI} from "./IUBI.sol";
import {Initializable} from "@openzeppelin/contracts/proxy/utils/Initializable.sol";
import {IERC20} from "@openzeppelin-contracts-5.0.2/token/ERC20/IERC20.sol";

contract UBI is IUBI, Initializable {
    using LibUBI for address;
    using LibUBI for LibUBI.UBIStorage;

    constructor() {
        _disableInitializers();
    }

    function initialize(
        uint256 _initialClaimValue,
        address _token
    ) public initializer {
        LibUBI.UBIStorage s = LibUBI.getStorage();
        s.initialClaimValue = _initialClaimValue;
        s.token = address(_token);
    }

    function claim(address to) external {
        LibUBI.UBIStorage storage s = LibUBI.getStorage();
        require(s.isAuthorizedToClaim(to), "Not authorized");
    }
}
