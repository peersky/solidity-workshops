pragma solidity =0.8.28;

import {Test} from "forge-std/Test.sol";
import {SimpleUBI} from "./SimpleUBI.sol";
import {ERC20Impl} from "./ERC20.sol";

contract SimpleUBITest is Test {
    SimpleUBI ubi;
    ERC20Impl token;

    function setUp() public {
        ubi = new SimpleUBI(true);
        token = new ERC20Impl("name", "symbol", address(this));
        ubi.initialize(1, address(token));
        token.transferOwnership(address(ubi));
    }

    function test_Ownership() public view {
        assertEq(address(token.owner()), address(ubi));
    }
}
