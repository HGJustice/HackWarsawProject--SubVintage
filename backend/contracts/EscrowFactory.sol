// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

import "contracts/Escrow.sol";

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
