// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './IERC20.sol';


contract PropertyContract{
    address public owner;
    uint256 public totalSupply;
    mapping(address => uint256) public balances;
    IERC20 public usdcToken;

    constructor(IERC20 _usdcToken) {
        owner = msg.sender;
        totalSupply = 1000;
        usdcToken = _usdcToken;
    }

    function buyTokens(uint256 amount) external {
        require(amount > 0, "Amount must be greater than zero");
        require(totalSupply >= amount, "Insufficient token supply");

        uint256 usdcAmount = amount * 1e18; // Assuming 1 PPT = 1 USDC (with 18 decimals)

        // Transfer USDC tokens from the buyer to the contract
        usdcToken.transferFrom(msg.sender, address(this), usdcAmount);

        // Transfer PPT tokens from the owner to the buyer
        balances[msg.sender] = balances[msg.sender] + amount;
        balances[owner] = balances[owner] - amount;
        totalSupply = totalSupply - amount;
    }

    function getMyBalance() public view returns(uint256){
        return balances[msg.sender];
    }

    function sellTokens(uint256 amount) external {
        require(amount > 0, "Amount must be greater than zero");
        require(balances[msg.sender] >= amount, "Insufficient token balance");

        uint256 usdcAmount = amount * 1e18; // Assuming 1 PPT = 1 USDC (with 18 decimals)

        // Transfer PPT tokens from the seller to the contract
        balances[msg.sender] = balances[msg.sender] - amount;
        balances[owner] = balances[owner] + amount;
        totalSupply = totalSupply + amount;

        // Transfer USDC tokens from the contract to the seller
        usdcToken.transfer(msg.sender, usdcAmount);
    }
}