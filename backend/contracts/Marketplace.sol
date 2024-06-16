// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

import "contracts/UserManagement.sol";
import "contracts/EscrowFactory.sol";

contract Marketplace {
    UserManagement private userContract;
    EscrowFactory private factoryContract;

    struct Listing {
        uint256 id;
        bytes32 pictureUrl;
        address owner;
        string description;
        uint256 price;
    }

    uint256 currentListingId = 1;
    uint256 accumlatedFees = 0;
    address owner;
    mapping(address userAddress => mapping(uint listingID => Listing)) userToListings;
    mapping(uint256 id => Listing) idToListings;

    event listingCreated(
        uint256 id,
        bytes32 picUrl,
        address owner,
        string description,
        uint256 price
    );
    event listingBought(uint256 id, address buyer, address escrowContract);

    constructor(address _contractAddy, address _factoryAddress) {
        userContract = UserManagement(_contractAddy);
        factoryContract = EscrowFactory(_factoryAddress);
        owner = msg.sender;
    }

    function createListing(
        bytes32 _ipfsLink,
        string calldata _description,
        uint256 _price
    ) external {
        UserManagement.User memory currentUser = userContract.getUser(
            msg.sender
        );
        require(currentUser.userAddy != address(0), "need to create user");

        Listing memory newListing = Listing(
            currentListingId,
            _ipfsLink,
            msg.sender,
            _description,
            _price
        );

        userToListings[msg.sender][currentListingId] = newListing;
        idToListings[currentListingId] = newListing;
        emit listingCreated(
            currentListingId,
            _ipfsLink,
            msg.sender,
            _description,
            _price
        );
        currentListingId++;
    }

    function getListing(uint listingID) external view returns (Listing memory) {
        return userToListings[msg.sender][listingID];
    }

    function getIDListing(
        uint listingID
    ) external view returns (Listing memory) {
        return idToListings[listingID];
    }

    function buyListing(uint256 _listingId) external payable {
        UserManagement.User memory currentUser = userContract.getUser(
            msg.sender
        );
        require(currentUser.userAddy != address(0), "need to create user");
        require(_listingId <= currentListingId, "invalid listing");
        Listing storage currentListing = idToListings[_listingId];
        //require(chainLink oracle check)

        // delete idToListings[_listingId];
        // delete userToListings[msg.sender][currentListingId];

        uint256 amountToEscrow = msg.value - 0.001 ether;
        accumlatedFees += 0.001 ether;

        address escrow = factoryContract.createEscrow{value: amountToEscrow}(
            msg.sender,
            currentListing.owner,
            amountToEscrow
        );
        emit listingBought(_listingId, msg.sender, escrow);
    }

    function withdrawFees() external {
        require(msg.sender == owner, "you are not the owner");
        (bool sent, ) = payable(owner).call{value: accumlatedFees}("");
        require(sent, "transfer of funds failed");
    }
}
