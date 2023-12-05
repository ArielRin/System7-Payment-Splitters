// SPDX-License-Identifier: MIT

// Use 0.8.18 to deploy
// splits balance equally among users
// add payees in this format : ["0x5B38Da6a701c568545dCfcB03FcB875f56beddC4", "0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2"]
// add an additional payee to the contract
// on clicking distribute button the payments are sent to payees.
// add wallets to the contract's address equal payments only in this contract

pragma solidity ^0.8.0;

interface IERC20 {
    function transfer(address to, uint256 value) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

contract Sys7NativeEqualSplitter {
    address[] public payees;
    address public owner;
    uint256 public totalDistributed; // New state variable to track total distributed amount

    constructor(address[] memory _payees) {
        require(_payees.length > 0, "No payees provided");

        owner = msg.sender;
        payees = _payees;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }

    receive() external payable {
        distribute();
    }

    function distribute() public payable {
        require(msg.value > 0, "No value sent");

        uint256 amountPerPayee = msg.value / payees.length;

        for (uint256 i = 0; i < payees.length; i++) {
            payable(payees[i]).transfer(amountPerPayee);
        }

        totalDistributed += msg.value; // Update total distributed amount
    }

    function updatePayees(address[] memory _payees) public onlyOwner {
        require(_payees.length > 0, "No payees provided");

        payees = _payees;
    }

    function addPayee(address newPayee) public onlyOwner {
        require(newPayee != address(0), "Invalid payee address");
        payees.push(newPayee);
    }

    // Function to withdraw ERC20 tokens sent to the contract
    function withdrawTokens(address tokenAddress) public onlyOwner {
        require(tokenAddress != address(0), "Invalid token address");

        IERC20 token = IERC20(tokenAddress);
        uint256 balance = token.balanceOf(address(this));

        require(balance > 0, "No tokens to withdraw");

        token.transfer(owner, balance);
    }

    // Function to withdraw native (Ether) sent to the contract
    function withdrawEther() public onlyOwner {
        uint256 balance = address(this).balance;

        require(balance > 0, "No Ether to withdraw");

        payable(owner).transfer(balance);
    }

    // Function to recover any ERC20 tokens mistakenly sent to the contract
    function recoverTokens(address tokenAddress, uint256 amount) public onlyOwner {
        require(tokenAddress != address(0), "Invalid token address");
        require(amount > 0, "Invalid amount");

        IERC20 token = IERC20(tokenAddress);
        require(token.transfer(owner, amount), "Token transfer failed");
    }

    // Function to recover any Ether mistakenly sent to the contract
    function recoverEther(uint256 amount) public onlyOwner {
        require(amount > 0, "Invalid amount");
        require(address(this).balance >= amount, "Not enough Ether to recover");

        payable(owner).transfer(amount);
    }

    // Function to transfer ownership of the contract
    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "Invalid new owner address");
        owner = newOwner;
    }

    // Function to display the balance of a specific ERC20 token
    function getTokenBalance(address tokenAddress) public view returns (uint256) {
        require(tokenAddress != address(0), "Invalid token address");
        IERC20 token = IERC20(tokenAddress);
        return token.balanceOf(address(this));
    }

    // Function to get the total distributed amount
    function getTotalDistributed() public view returns (uint256) {
        return totalDistributed;
    }

    // Function to get the number of payees
    function getNumberOfPayees() public view returns (uint256) {
        return payees.length;
    }

    function getPayeeList() external view returns (address[] memory) {
        return payees;
    }
}
