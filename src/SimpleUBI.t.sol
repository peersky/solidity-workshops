pragma solidity =0.8.28;

import {Test} from "forge-std/Test.sol";
import {SimpleUBI} from "./SimpleUBI.sol";
import {ERC20Impl} from "./ERC20.sol";
import {MyZKVerifier} from "./MyZKVerifier.sol";

contract SimpleUBITest is Test {
    SimpleUBI ubi;
    ERC20Impl token;
    MyZKVerifier verifier;

    function setUp() public {
        ubi = new SimpleUBI(true);
        token = new ERC20Impl("name", "symbol", address(this));
        verifier = new MyZKVerifier();
        ubi.initialize(1, address(token), address(verifier));
        token.transferOwnership(address(ubi));
    }

    function test_Ownership() public view {
        assertEq(address(token.owner()), address(ubi));
    }

    function test_Claim() public {
        verifier.verify(address(this), "");
        uint256 balance = token.balanceOf(address(this));
        ubi.claim(address(this));
        assertEq(token.balanceOf(address(this)), balance + 1);
    }
}
