// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.8.19;

// interfaces

// libraries

// contracts
import {PRBTest} from "@prb/test/PRBTest.sol";
import {StdCheats} from "forge-std/Test.sol";

abstract contract BaseTest is PRBTest, StdCheats {
  struct Users {
    address payable owner;
    address payable stranger;
  }

  Users public users;

  function setUp() public virtual {
    users = Users(createUser("owner"), createUser("stranger"));
  }

  /// @dev Create a new account and fund it with 100 ether.
  function createUser(
    string memory name
  ) public returns (address payable addr) {
    addr = payable(makeAddr(name));
    vm.deal(addr, 100 ether);
  }

  /// @dev Expects an event to be emitted.
  function expectEmit() public {
    vm.expectEmit(true, true, true, true);
  }

  /// @dev Expect an event to be emitted with the given emitter.
  function expectEmit(address emitter) public {
    vm.expectEmit(true, true, true, true, emitter);
  }
}
