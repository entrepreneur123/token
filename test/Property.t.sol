// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/PropertyContract.sol";

contract PropertyContractTest is Test {
    PropertyContract public propertyContract;

    function setUp() public {
        propertyContract = new PropertyContract();
        propertyContract.setNumber(0);
    }

    function testIncrement() public {
        propertyContract.increment();
        assertEq(propertyContract.number(), 1);
    }

    function testSetNumber(uint256 x) public {
        propertyContract.setNumber(x);
        assertEq(propertyContract.number(), x);
    }
}
