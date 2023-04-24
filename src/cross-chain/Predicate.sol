// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.8.19;

// interfaces
import {IPredicate} from "./interfaces/IPredicate.sol";

// libraries
import {EnumerableSet} from "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";

// contracts

contract Predicate is IPredicate {
  using EnumerableSet for EnumerableSet.AddressSet;
  using EnumerableSet for EnumerableSet.UintSet;

  // space address => chain id => [entitlement addresses]
  mapping(address => mapping(uint => EnumerableSet.AddressSet))
    private entitlements;

  // chain ids
  EnumerableSet.UintSet private chainIds;

  function add(address _space, address _entitlement, uint _chainId) external {
    // TODO: check if caller is space owner

    bool added = entitlements[_space][_chainId].add(_entitlement);
    require(added, "Predicate: already added");

    chainIds.add(_chainId);

    // TODO: emit event
  }

  function remove(
    address _space,
    address _entitlement,
    uint _chainId
  ) external {
    // TODO: check if caller is space owner

    bool removed = entitlements[_space][_chainId].remove(_entitlement);
    require(removed, "Predicate: not found");

    // TODO: emit event
  }

  function getAll(
    address _space
  ) external view returns (Entitlement[] memory allEntitlements) {
    uint totalEntitlements;
    uint chainIdsLen = chainIds.length();

    for (uint i; i < chainIdsLen; i++) {
      uint chainId = chainIds.at(i);
      totalEntitlements += entitlements[_space][chainId].length();
    }

    allEntitlements = new Entitlement[](totalEntitlements);
    uint idx;

    // Loop over all chain IDs
    for (uint j; j < chainIdsLen; j++) {
      uint chainId = chainIds.at(j);

      // Get length of entitlements for this chain ID
      uint len = entitlements[_space][chainId].length();
      // Get all addresses
      address[] memory entitlementAddrs = entitlements[_space][chainId]
        .values();

      // Loop over all addresses
      for (uint k; k < len; k++) {
        // Add each Entitlement to the array
        allEntitlements[idx] = Entitlement({
          entitlementAddress: entitlementAddrs[k],
          chainId: chainId
        });
        idx++;
      }
    }
  }

  function count(address _space) external view returns (uint entitlementCount) {
    uint chainIdsLen = chainIds.length();

    for (uint i; i < chainIdsLen; i++) {
      uint chainId = chainIds.at(i);
      entitlementCount += entitlements[_space][chainId].length();
    }
  }
}
