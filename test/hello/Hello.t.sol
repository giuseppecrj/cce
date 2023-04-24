// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

//interfaces

//libraries

//contracts
import {BaseTest} from "../Base.t.sol";
import {Hello} from "src/Hello.sol";

contract HelloTest is BaseTest {
  Hello internal hello;

  function setUp() public virtual override {
    super.setUp();

    hello = new Hello();
  }

  function test_sayHello() external {
    assertEq(hello.sayHello(), "Hello, Forge!");
  }
}
