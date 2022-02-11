// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.11;
import {IERC20} from "openzeppelin-contracts/token/ERC20/IERC20.sol";
import {SafeERC20} from "openzeppelin-contracts/token/ERC20/utils/SafeERC20.sol";

import {IWETH} from "./interfaces/IWETH.sol";

contract Contract{
    using SafeERC20 for IERC20;

    uint public z;
    IWETH immutable weth;
    event ZEvent(uint256 a, uint256 b, address c);

    constructor(address _weth){
        weth = IWETH(_weth);
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
