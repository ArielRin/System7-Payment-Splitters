// Auto native splitter contract


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v4.5/contracts/token/ERC20/IERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v4.5/contracts/access/Ownable.sol";

contract NativeAutoSplitter is Ownable {
    address[] public wallets;
    uint256[] public ratios;
    address public operator;
    uint256 public totalDistributed;

    event EtherDistributed(address indexed wallet, uint256 amount);
    event EtherBalanceChecked(uint256 balance);
    event OperatorChanged(address newOperator);
    event TokensRecovered(address indexed token, uint256 amount);

    modifier onlyOperator() {
        require(msg.sender == operator || msg.sender == owner(), "Not authorized");
        _;
    }

    constructor(
        address[] memory _wallets,
        uint256[] memory _ratios,
        address _operator
    ) {
        require(_wallets.length == _ratios.length, "Mismatched arrays");

        wallets = _wallets;
        ratios = _ratios;
        operator = _operator;
    }

    receive() external payable {
        distributeEther();
    }

    function distributeEther() public payable onlyOperator {
        require(wallets.length > 0, "No wallets specified");
        require(wallets.length == ratios.length, "Mismatched arrays");
        require(msg.value > 0, "No ether sent");

        uint256 totalBalance = address(this).balance;

        for (uint256 i = 0; i < wallets.length; i++) {
            uint256 share = (totalBalance * ratios[i]) / 100;
            payable(wallets[i]).transfer(share);
            emit EtherDistributed(wallets[i], share);
            totalDistributed += share;
        }
    }

    function recoverLostEther(uint256 _amount) external onlyOwner {
        require(_amount <= address(this).balance, "Insufficient balance");
        payable(owner()).transfer(_amount);
    }

    function recoverLostTokens(address _token, uint256 _amount) external onlyOwner {
        require(_token != address(0), "Invalid token address");
        IERC20 tokenToRecover = IERC20(_token);
        require(tokenToRecover.transfer(owner(), _amount), "Token recovery failed");
        emit TokensRecovered(_token, _amount);
    }

    function transferOwnershipAndOperator(address _newOwner, address _newOperator) external onlyOwner {
        transferOwnership(_newOwner);
        operator = _newOperator;
        emit OperatorChanged(_newOperator);
    }

    function setOperator(address _newOperator) external onlyOwner {
        operator = _newOperator;
        emit OperatorChanged(_newOperator);
    }

    function getEtherBalance() external view returns (uint256) {
        return address(this).balance;
    }

    function updateWalletsAndRatios(address[] memory _newWallets, uint256[] memory _newRatios) external onlyOwner {
        require(_newWallets.length == _newRatios.length, "Mismatched arrays");
        wallets = _newWallets;
        ratios = _newRatios;
    }

    function getWalletList() external view returns (address[] memory) {
        return wallets;
    }

    function getRatioList() external view returns (uint256[] memory) {
        return ratios;
    }
}
