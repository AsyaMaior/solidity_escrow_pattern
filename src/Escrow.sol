//SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

contract Escrow {
    error NotAnArbiter();

    event Deposit(uint256 amount);
    event Approve(uint256 amount);

    address public depositor;
    address public beneficiary;
    address public arbiter;

    constructor(address _beneficiary, address _arbiter) payable {
        depositor = msg.sender;
        beneficiary = _beneficiary;
        arbiter = _arbiter;

        emit Deposit(msg.value);
    }

    modifier onlyArbiter() {
        if (msg.sender != arbiter) {
            revert NotAnArbiter();
        }
        _;
    }

    function approve() external onlyArbiter {
        uint256 amount = address(this).balance;
        payable(beneficiary).transfer(amount);

        emit Approve(amount);
    }
}
