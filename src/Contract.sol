// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.11;

contract Contract{

    uint public z;
    event ZEvent(uint256 a, uint256 b, address c);

    constructor(){
    }

    function testemit(uint256 _z) external {
        z = _z;
        _callN(msg.sender, 1);
        emit ZEvent(1, 2, msg.sender);
    }

    function testemitWOCall(uint256 _z) external {
        z = _z;
        emit ZEvent(1, 2, msg.sender);
    }

    function _callN(address _to, uint256 _amount) internal {
        (bool success, ) = _to.call{value: _amount, gas: 30_000}(new bytes(0));
    }
}
