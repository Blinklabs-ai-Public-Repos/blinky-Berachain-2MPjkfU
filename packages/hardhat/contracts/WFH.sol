// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract WFH is ERC20, Ownable {
    uint256 private constant INITIAL_SUPPLY = 1000000 * 10**18; // 1 million tokens with 18 decimals

    constructor(string memory name_, string memory symbol_) ERC20(name_, symbol_) {
        _mint(msg.sender, INITIAL_SUPPLY);
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
    }

    function transferWithCallback(address recipient, uint256 amount) public returns (bool) {
        bool success = transfer(recipient, amount);
        if (success) {
            emit TransferWithCallback(msg.sender, recipient, amount);
        }
        return success;
    }

    event TransferWithCallback(address indexed from, address indexed to, uint256 value);
}