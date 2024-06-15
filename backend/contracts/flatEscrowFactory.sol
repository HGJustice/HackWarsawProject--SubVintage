// SPDX-License-Identifier: MIT
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

pragma solidity 0.8.22;

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
