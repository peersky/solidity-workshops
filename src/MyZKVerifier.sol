// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;
import {Verifier} from "./Verifier.sol";

contract MyZKVerifier is Verifier {
    function verify(address user, bytes memory data) public {
        _verify(user, data);
    }
}
