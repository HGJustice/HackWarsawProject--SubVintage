// SPDX-License-Identifier: MIT
// File: contracts/UserManagement.sol

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

// File: contracts/Escrow.sol

pragma solidity 0.8.22;

contract Escrow {
    address public buyer;
    address public seller;
    bool public buyerApproveBool = false;
    bool public sellerApproveBool = false;
    uint256 amount;
    string trackingNum;

    constructor(address _buyer, address _seller, uint256 _amount) payable {
        buyer = _buyer;
        seller = _seller;
        amount = _amount;
    }

    event sellerApproved(address seller, bool result, string proof);
    event buyerApproveed(address buyer, bool result);

    function sellerApprove(string calldata _trackingNum) external {
        require(msg.sender == seller, "you are not the seller");
        sellerApproveBool = true;
        trackingNum = _trackingNum;
        emit sellerApproved(msg.sender, sellerApproveBool, _trackingNum);
    }

    function buyerApproves() external {
        require(msg.sender == buyer, "you are no the customer");
        buyerApproveBool = true;
        emit buyerApproveed(buyer, buyerApproveBool);
    }

    function refundBuyer() external {
        require(msg.sender == seller, "you are not the seller");
        require(!buyerApproveBool, "too late to refund, buyer approved");
        (bool sent, ) = payable(buyer).call{value: amount}("");
        require(sent, "refund of eth failed");
    }

    function withdrawAmount() external {
        require(msg.sender == seller, "you are not the seller");
        require(
            sellerApproveBool && buyerApproveBool,
            "someone hasnt approved"
        );
        (bool sent, ) = payable(seller).call{value: amount}("");
        require(sent, "transger of amount ot seller failed");
    }
}

// File: contracts/EscrowFactory.sol

contract EscrowFactory {
    event EscrowContractCreated(
        address escrowLocation,
        address _buyer,
        address _seller,
        uint256 amount
    );

    function createEscrow(
        address _buyer,
        address _seller,
        uint256 _amount
    ) external payable returns (address) {
        require(msg.value >= _amount, "invalid amount for listing");
        Escrow newEsrow = (new Escrow){value: msg.value}(
            _buyer,
            _seller,
            _amount
        );
        emit EscrowContractCreated(address(newEsrow), _buyer, _seller, _amount);
        return address(newEsrow);
    }
}

// File: contracts/Marketplace.sol

contract Marketplace {
    UserManagement private userContract;
    EscrowFactory private factoryContract;

    struct Listing {
        uint256 id;
        bytes32 pictureUrl;
        address owner;
        string title;
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
        string calldata _title,
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
            _title,
            _description,
            _price
        );

        userToListings[msg.sender][currentListingId] = newListing;
        idToListings[currentListingId] = newListing;
        emit listingCreated(currentListingId, msg.sender, _description, _price);
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
