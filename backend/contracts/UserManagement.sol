// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

contract UserManagement {
    struct User {
        uint256 id;
        string username;
        address userAddy;
    }

    event userCreated(uint256 id, string username);

    uint256 currentUserId = 1;
    mapping(address => User) users;

    function createUser(string calldata _username) external {
        require(
            users[msg.sender].userAddy == address(0),
            "user already created"
        );

        User memory newUser = User(currentUserId, _username, msg.sender);

        users[msg.sender] = newUser;
        emit userCreated(currentUserId, _username);
        currentUserId++;
    }

    function getUser(address _userAddy) external view returns (User memory) {
        return users[_userAddy];
    }
}
