// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "../Clone.sol";

contract CloneFactory {
    using Clone for *;

    function clone(address contractToClone) external returns (address cloned) {
        return contractToClone._clone();
    }

    function clone2(address contractToClone, bytes32 salt) external returns (address cloned) {
        return contractToClone._clone2(salt);
    }

    function predictClonedAddress(
        address contractToClone,
        bytes32 salt
    ) external view returns (address clonedAddress) {
        return contractToClone._predictClonedAddress(salt);
    }

}