// SPDX-License-Identifier: MIT

/*

```markdown
# TokenSplitter Smart Contract

## Overview

The TokenSplitter smart contract allows you to distribute tokens among multiple wallets based on specified ratios. Additionally,
it provides functionality for recovering lost tokens, recovering native tokens, and managing ownership and operators.

## Usage

### Deployment

1. Deploy the TokenSplitter smart contract on the Ethereum blockchain.

### Set Wallets and Ratios

2. After deployment, set the wallets and ratios using the `setWalletsAndRatios` function.

   - Call `setWalletsAndRatios` with an array of wallet addresses and an array of corresponding ratios.
   - Example:

   ```json
   {
     "_wallets": ["0xWallet1", "0xWallet2", "0xWallet3"],
     "_ratios": [30, 40, 30]
   }
   ```

### Distribute Tokens

3. Execute the `distributeTokens` function to distribute tokens to the specified wallets based on the set ratios.

   - Only the operator or the contract owner can execute this function.

### Recover Lost Tokens

4. If any non-native tokens are accidentally sent to the contract, you can recover them using the `recoverLostTokens` function.

   - Call `recoverLostTokens` with the address of the token and the amount to recover.

### Recover Native Tokens

5. Recover native tokens (the token the contract is designed to split) using the `recoverNativeTokens` function.

   - Call `recoverNativeTokens` with the amount to recover.

### Change Ownership and Operator

6. Transfer ownership and change the operator using the `transferOwnershipAndOperator` function.

   - Only the contract owner can execute this function.

### Set Operator

7. Set a new operator using the `setOperator` function.

   - Only the contract owner can execute this function.

### Change Operator

8. Change the operator using the `changeOperator` function.

   - Only the current operator or the contract owner can execute this function.

## Security

- Ensure that you thoroughly test the contract on a testnet before deploying it on the mainnet.
- Consider obtaining a professional audit for the smart contract.
- Be cautious with the ownership and operator functions, as they can impact the security of the contract.

## Disclaimer

This smart contract and README are provided for educational purposes. Use at your own risk. Always follow best practices for smart contract development and security.
```

This README file provides a step-by-step guide on how to operate the TokenSplitter contract after deployment,
including setting wallets and ratios, distributing tokens, recovering lost and native tokens, and managing ownership and operators.
Customize it according to your specific contract details and deployment process.

 token 0x6CB6c8D16e7B6Fd5A815702B824e6Dfdf148a7D9
 wallets
 ["0x18Ff7f454B6A3233113f51030384F49054DD27BF","0xc690fE0d47803ed50E1EA7109a9750360117aa22"]
 ratios
 ["40","60"]
 operator: 0x18Ff7f454B6A3233113f51030384F49054DD27BF
*/
pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v4.5/contracts/token/ERC20/IERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v4.5/contracts/access/Ownable.sol";

contract TokenSplitter is Ownable {
    IERC20 public token;
    address[] public wallets;
    uint256[] public ratios;
    address public operator;
    uint256 public totalDistributed;

    event TokensDistributed(address indexed wallet, uint256 amount);
    event TokenBalanceChecked(uint256 balance);
    event TokenChanged(address newToken);
    event EtherDistributed(address indexed wallet, uint256 amount);

    modifier onlyOperator() {
        require(msg.sender == operator || msg.sender == owner(), "Not authorized");
        _;
    }

    constructor(
        address _token,
        address[] memory _wallets,
        uint256[] memory _ratios,
        address _operator
    ) {
        require(_wallets.length == _ratios.length, "Mismatched arrays");

        token = IERC20(_token);
        wallets = _wallets;
        ratios = _ratios;
        operator = _operator;
    }

    function distributeTokens() external onlyOperator {
        require(wallets.length > 0, "No wallets specified");
        require(wallets.length == ratios.length, "Mismatched arrays");

        uint256 totalBalance = token.balanceOf(address(this));

        for (uint256 i = 0; i < wallets.length; i++) {
            uint256 share = (totalBalance * ratios[i]) / 100;
            require(token.transfer(wallets[i], share), "Transfer failed");
            emit TokensDistributed(wallets[i], share);
            totalDistributed += share;
        }
    }

    function recoverLostTokens(uint256 _amount) external onlyOwner {
        require(token.transfer(owner(), _amount), "Recovery failed");
    }

    function transferOwnershipAndOperator(address _newOwner, address _newOperator) external onlyOwner {
        transferOwnership(_newOwner);
        operator = _newOperator;
    }

    function setOperator(address _newOperator) external onlyOwner {
        operator = _newOperator;
    }

    function getTokenBalance() external view returns (uint256) {
        return token.balanceOf(address(this));
    }

    function setTokenToSplit(address _newToken) external onlyOwner {
        require(_newToken != address(0), "Invalid token address");
        token = IERC20(_newToken);
        emit TokenChanged(_newToken);
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
