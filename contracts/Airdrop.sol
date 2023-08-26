// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

//import IERC20
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "hardhat/console.sol";
contract Airdrop is Ownable {
    IERC20 public token;
    bytes32 public root;
    bool public isAirdropActive = false;

    event Claimed(address addr, uint256 amount);

    mapping(address => bool) public claimed;

    constructor(bytes32 _root, IERC20 _token) {
        root = _root;
        token = _token;
    }

    function updateRoot(bytes32 _root) public onlyOwner {
        root = _root;
    }

    function updateToken(IERC20 _token) public onlyOwner {
        token = _token;
    }

    function updateAirdropStatus(bool _isAirdropActive) public onlyOwner {
        isAirdropActive = _isAirdropActive;
    }

    function claim(bytes32[] memory proof, uint256 amount) public {
        require(isAirdropActive, "Airdrop is not active");
        require(!claimed[msg.sender], "Already claimed");
        console.log("msg.sender: %s", msg.sender);
        bytes32 leaf = keccak256(
            bytes.concat(keccak256(abi.encode(msg.sender, amount)))
        );
        require(MerkleProof.verify(proof, root, leaf), "Invalid proof");
        IERC20(token).transfer(msg.sender, amount);
        claimed[msg.sender] = true;
        emit Claimed(msg.sender, amount);
    }

    function emergencyWithdraw(uint256 _amount) public onlyOwner {
        IERC20(token).transfer(msg.sender, _amount);
    }
}
/// signature: address-startclaim -endclaim - tge