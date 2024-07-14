// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";

contract ERC20GovMinimal is ERC20Upgradeable {

    struct InitSupply {
        address user;
        uint256 amount;
    }

    function __ERC20GovMinimal_init(
        string calldata name,
        string calldata symbol,
        InitSupply[] calldata initSupply
    ) external initializer {
        __ERC20_init(name, symbol);

        for (uint256 i = 0; i < initSupply.length; i++) {
            _mint(initSupply[i].user, initSupply[i].amount);
        }
    }
}
