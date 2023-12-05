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
