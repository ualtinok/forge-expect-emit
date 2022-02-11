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
    error Insolvent();
    error EthTransferFailedDestOrAmountZero();

    constructor(address _weth){
        weth = IWETH(_weth);
    }

    function testemit(uint256 _z) external {
        z = _z;
        _safeTransferETHWithFallback(msg.sender, 1);
        emit ZEvent(1, 2, msg.sender);
    }

    function _safeTransferETHWithFallback(address _to, uint256 _amount) internal {
        if (_amount == 0 || _to == address(0)) {
            revert EthTransferFailedDestOrAmountZero();
        }
        if (address(this).balance < _amount) {
            revert Insolvent();
        }
        (bool success, ) = _to.call{value: _amount, gas: 30_000}(new bytes(0));
        if (!success) {
            weth.deposit{value: _amount}();
            IERC20(address(weth)).safeTransfer(_to, _amount);
        }
    }
}
