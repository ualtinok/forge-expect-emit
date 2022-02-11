// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.11;

import "ds-test/test.sol";
import "forge-std/Vm.sol";

import "../Contract.sol";

contract ContractTest is DSTest {
    event ZEvent(uint256 a, uint256 b, address c);

    Vm constant vm = Vm(HEVM_ADDRESS);

    Contract c1;

    function setUp() public {
        c1 = new Contract();
        vm.deal(address(c1), 100 ether);
    }

    function testexpectEmitWOCall0() public {
        vm.expectEmit(true, false, false, true);
        emit ZEvent(1, 2, address(this)); // should pass
        c1.testemitWOCall(10);
    }

    function testexpectEmitWOCall1() public {
        vm.expectEmit(true, false, false, true);
        emit ZEvent(4232, 232, address(this)); // should fail and correctly fails
        c1.testemitWOCall(10);
    }

    function testexpectEmitWOCall2() public {
        vm.expectEmit(true, false, false, true);
        // emit ZEvent(4232, 232, address(this)); // also should fail and correctly fails
        c1.testemitWOCall(10);
    }

    function testExpectEmit0() public {
        vm.expectEmit(true, false, false, true);
        emit ZEvent(1, 2, address(this)); // should pass
        c1.testemit(10);
    }

    function testExpectEmit() public {
        vm.expectEmit(true, false, false, true);
        emit ZEvent(42893283, 4223232, address(this)); // should fail but doesn't
        c1.testemit(10);
    }

    function testExpectEmit2() public {
        vm.expectEmit(true, false, false, true);
        //emit ZEvent(42893283, 4223232, address(this)); // also should fail but doesn't
        c1.testemit(10);
    }

    function testExpectEmit3() public {
        vm.expectEmit(false, false, false, false);
        emit ZEvent(42893283, 4223232, address(this)); // also should fail but doesn't
        c1.testemit(10);
    }

    function testExpectEmit4() public {
        vm.expectEmit(true, false, false, true);
        //emit ZEvent(42893283, 4223232, address(this)); // also should fail but doesn't
        c1.testemit(10);
    }

}
