// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MockERC20 is ERC20 {
    constructor() ERC20("MockERC20", "MockERC20") {
        _mint(msg.sender, 10000 ether);
    }

    function mint(address _to, uint256 _amount) public {
        _mint(_to, _amount);
    }
}
