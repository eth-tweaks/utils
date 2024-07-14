// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;


contract Clone {

    bytes32 constant DEPLOY_PREFIX = hex"61000080600a3d3981f3";
//                                         61000080600c6000396000f3

    function clone(address contractToClone) external returns (address cloned) {
        bytes memory bytecode = contractToClone.code;
        uint256 bytecodeSize = bytecode.length;
        uint8 lowerByte = uint8(bytecodeSize);
        uint8 upperByte = uint8(bytecodeSize / 256);

        assembly {
            mstore(bytecode, DEPLOY_PREFIX)
            mstore8(add(bytecode, 24), lowerByte)
            mstore8(add(bytecode, 25), upperByte)

            cloned := create(0, add(bytecode, 23), bytecodeSize)
        }
    }

    function clone2(address contractToClone, bytes32 salt) external returns (address cloned) {
        bytes memory bytecode = contractToClone.code;
        uint256 bytecodeSize = bytecode.length;
        uint8 lowerByte = uint8(bytecodeSize);
        uint8 upperByte = uint8(bytecodeSize / 256);

        assembly {
            mstore(bytecode, DEPLOY_PREFIX)
            mstore8(add(bytecode, 24), lowerByte)
            mstore8(add(bytecode, 25), upperByte)

            cloned := create2(0, add(bytecode, 23), bytecodeSize, salt)
        }
    }

    function predictClone2Address(address contractToClone, bytes32 salt) external view returns (address clonedAddress) {
        bytes memory originalBytecode = contractToClone.code;
        bytes memory bytecode = abi.encodePacked(bytes10(DEPLOY_PREFIX), originalBytecode);
        bytecode[2] = bytes1(uint8(originalBytecode.length));
        bytecode[1] = bytes1(uint8(originalBytecode.length / 256));

        clonedAddress = address(uint160(uint256(keccak256(abi.encodePacked(
            hex'ff',
            address(this),
            salt,
            keccak256(bytecode)
        )))));
    }
}