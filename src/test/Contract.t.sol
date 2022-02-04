// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.11;

import "ds-test/test.sol";
import "forge-std/Vm.sol";

import "../Contract.sol";
import "openzeppelin-contracts/proxy/transparent/TransparentUpgradeableProxy.sol";

contract ContractTest is DSTest {
    Vm constant vm = Vm(HEVM_ADDRESS);

    Contract c1;
    Contract c2;

    function setUp() public {
        c1 = new Contract();
        c2 = Contract(
            deployProxy(
                type(Contract).creationCode,
                address(1), // proxyAdmin
                new bytes(0) // init calldata
            )
        );
    }

    event Updated(uint u1);

    function testEvent1c1() public {
        // Calling update before vm.expectEmit
        c1.update(1337);

        vm.expectEmit(false, false, false, true);
        emit Updated(0); // wrong

        assertEq(c1.u(), 1337);
    }

    function testEvent1c2() public {
        // Calling update before vm.expectEmit
        c2.update(1337);

        vm.expectEmit(false, false, false, true);
        emit Updated(0); // wrong

        assertEq(c2.u(), 1337);
    }

    function testEvent2c1() public {
        vm.expectEmit(false, false, false, true);
        emit Updated(0); // wrong

        c1.update(1337);
    }

    function testEvent2c2() public {
        vm.expectEmit(false, false, false, true);
        emit Updated(0); // wrong

        c2.update(1337);
    }

    /// ============================
    /// ===== Internal helpers =====
    /// ============================

    function deployProxy(
        bytes memory _creationCode,
        address _admin,
        bytes memory _data
    ) internal returns (address proxy_) {
        address logic;
        assembly {
            logic := create(0, add(_creationCode, 0x20), mload(_creationCode))
        }

        proxy_ = address(new TransparentUpgradeableProxy(logic, _admin, _data));
    }

}
