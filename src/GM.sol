// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { ERC20Burnable, ERC20 } from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";

contract GM is ERC20Burnable, Ownable {
    error GM__AmountMustBeMoreThanZero();
    error GM__BurnAmountExceedsBalance();
    error GM__NotZeroAddress();

    constructor() ERC20("Glamour Metrix", "GM") Ownable(msg.sender) {

    }

    function burn(uint256 _amount) public override onlyOwner {
        uint256 balance = balanceOf(msg.sender);
        if (_amount <= 0){
            revert GM__AmountMustBeMoreThanZero();
        }
        if (balance < _amount){
            revert GM__BurnAmountExceedsBalance();
        }
        super.burn(_amount);
    }

    function mint(address _to, uint256 _amount) external onlyOwner returns (bool){
        if (_to == address(0)){
            revert GM__NotZeroAddress();
        }

        if (_amount <= 0){
            revert GM__AmountMustBeMoreThanZero();
        }

        _mint(_to, _amount);
        return true;
    }
}
