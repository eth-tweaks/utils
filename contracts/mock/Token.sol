// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";

contract Token is ERC20Upgradeable {

    function __Token_init(
        string calldata name,
        string calldata symbol
    ) external initializer {
        __ERC20_init(name, symbol);

        _mint(msg.sender, 10 ** (decimals() + 9));
    }
}
