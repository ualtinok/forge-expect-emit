// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.11;

contract Contract {
    uint public u;

    event Updated(uint u);

    function update(uint _u) public {
        u = _u;
        emit Updated(_u);
    }
}
