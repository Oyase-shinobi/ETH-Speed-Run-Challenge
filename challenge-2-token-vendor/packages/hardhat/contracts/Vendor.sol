pragma solidity 0.8.4; //Do not change the solidity version as it negatively impacts submission grading
// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/access/Ownable.sol";
import "./YourToken.sol";

contract Vendor is Ownable {
    uint256 public constant tokensPerEth = 100;
    event BuyTokens(address buyer, uint256 amountOfETH, uint256 amountOfTokens);
    event SellTokens(address seller, uint256 amountOfTokens, uint256 amountOfETH);

    YourToken public yourToken;
    address public _owner;

    // Custom Errors
    error OnlyOwner(); 
    error InsufficientBalance();  
    error InsufficientContractETH();  

    constructor(address tokenAddress) {
        yourToken = YourToken(tokenAddress);
        _owner = msg.sender;
    }

    // ToDo: create a payable buyTokens() function:
    function buyTokens() public payable {
        uint256 tokenAmount = msg.value * tokensPerEth;
        yourToken.transfer(msg.sender, tokenAmount);
        emit BuyTokens(msg.sender, msg.value, tokenAmount);
    }

    // ToDo: create a withdraw() function that lets the owner withdraw ETH
    function withdraw() public {
        if (msg.sender != _owner) {
            revert OnlyOwner(); // Custom error for non-owner access
        }
        payable(_owner).transfer(address(this).balance);
    }

    // ToDo: create a sellTokens(uint256 _amount) function:
    function sellTokens(uint256 _amount) public {
        if (yourToken.balanceOf(msg.sender) < _amount) {
            revert InsufficientBalance(); 
        }
        uint256 ethAmount = _amount / tokensPerEth;
        if (address(this).balance < ethAmount) {
            revert InsufficientContractETH();  
        }

        yourToken.transferFrom(msg.sender, address(this), _amount);
        payable(msg.sender).transfer(ethAmount);
        emit SellTokens(msg.sender, _amount, ethAmount);
    }
}
