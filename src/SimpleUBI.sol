// SPDX-License-Identifier: MIT
pragma solidity =0.8.28;
import {LibUBI, UBIStorage} from "./LibUBI.sol";
import {IUBI} from "./IUBI.sol";
import {Initializable} from "@openzeppelin/contracts/proxy/utils/Initializable.sol";
import {IERC20} from "@openzeppelin-contracts-5.0.2/token/ERC20/IERC20.sol";
import {IVerifier} from "./IVerifier.sol";
import {ERC20Impl} from "./ERC20.sol";

contract SimpleUBI is IUBI, Initializable {
    using LibUBI for address;
    using LibUBI for UBIStorage;

    constructor(bool test) {
        if (!test) {
            _disableInitializers();
        }
    }

    function initialize(
        uint256 _initialClaimValue,
        address _token,
        address _verifier
    ) public initializer {
        UBIStorage storage s = LibUBI.getStorage();
        s.claimAmount = _initialClaimValue;
        s.token = address(_token);
        s.verifier = _verifier;
    }

    function claim(address to) external {
        UBIStorage storage s = LibUBI.getStorage();
        (bool isVerified, ) = IVerifier(s.verifier).getUser(to);
        require(isVerified, "Not authorized");
        ERC20Impl(s.token).mint(to, s.claimAmount);
    }
}
