// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.8.19;

// interfaces

// libraries

// contracts

contract TokenEntitlement {
  struct Token {
    address contractAddress;
    uint256 quantity;
    bool isSingleToken;
    uint256[] tokenIds;
  }

  Token[] public tokens;

  function add(
    address _contractAddress,
    uint256 _quantity,
    bool _isSingleToken,
    uint256[] memory _tokenIds
  ) external {
    tokens.push(Token(_contractAddress, _quantity, _isSingleToken, _tokenIds));
  }

  function remove(address _contractAddress, uint256 _quantity) external {
    for (uint i; i < tokens.length; i++) {
      if (
        tokens[i].contractAddress == _contractAddress &&
        tokens[i].quantity == _quantity
      ) {
        tokens[i] = tokens[tokens.length - 1];
        tokens.pop();
        break;
      }
    }
  }
}

contract UserEntitlement {
  struct User {
    address userAddress;
  }

  User[] public users;

  function add(address _userAddress) external {
    users.push(User(_userAddress));
  }

  function remove(address _userAddress) external {
    for (uint i; i < users.length; i++) {
      if (users[i].userAddress == _userAddress) {
        users[i] = users[users.length - 1];
        users.pop();
        break;
      }
    }
  }
}
