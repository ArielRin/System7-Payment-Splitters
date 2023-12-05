# Native Token Splitter


The EtherSplitter contract is a smart contract written in Solidity that facilitates the distribution of Ether among multiple wallets based on specified ratios. This README provides a detailed explanation of the contract's functionality, deployment, and usage.

## Overview

The EtherSplitter contract allows an owner to distribute Ether among a predefined set of wallets according to specified ratios. It provides flexibility in adjusting the wallet addresses, distribution ratios, and the ability to pause and resume the distribution process.

## Contract Structure

### Wallets and Ratios

The contract is initialized with an array of wallet addresses (`wallets`) and an array of corresponding distribution ratios (`ratios`). These ratios determine the percentage of Ether each wallet should receive during distribution.

### Pausing Distribution

The contract features a pausing mechanism (`isPaused`) that allows the owner to temporarily halt the distribution process. This can be useful in certain situations, such as unexpected issues or changes in the distribution setup.

### Functions

1. **`distributeEther`**
   - **Description:** Initiates the distribution of Ether to the specified wallets based on the defined ratios.
   - **Access:** Only the owner can execute this function.
   - **Conditions:** The contract must not be paused, and there should be Ether available for distribution.

2. **`toggleDistributionPause`**
   - **Description:** Toggles the distribution pause state.
   - **Access:** Only the owner can execute this function.

3. **`updateWalletsAndRatios`**
   - **Description:** Allows the owner to update the wallet addresses and their corresponding ratios.
   - **Access:** Only the owner can execute this function.
   - **Conditions:** The new arrays must have the same length.

4. **`getWalletList`**
   - **Description:** Retrieves the list of wallet addresses.
   - **Access:** Publicly accessible.

5. **`getRatioList`**
   - **Description:** Retrieves the list of distribution ratios.
   - **Access:** Publicly accessible.

6. **`getEtherBalance`**
   - **Description:** Retrieves the current Ether balance of the contract.
   - **Access:** Publicly accessible.

## Usage

### Deployment

1. Deploy the EtherSplitter contract on the Ethereum blockchain using a compatible development environment such as Remix or Truffle.

### Initialization

1. Set the initial wallet addresses and distribution ratios when deploying the contract.

### Interaction

1. **Receive Ether:**
   - Send Ether to the EtherSplitter contract address.

2. **Distribute Ether:**
   - Call the `distributeEther` function to distribute Ether to the specified wallets based on the defined ratios.

3. **Pause/Resume Distribution:**
   - Toggle the distribution pause state using the `toggleDistributionPause` function.

4. **Update Wallets and Ratios:**
   - Adjust the list of wallets and their ratios using the `updateWalletsAndRatios` function.

## Considerations

- Ensure that the contract has enough Ether for distribution.
- Carefully review and test wallet addresses and distribution ratios before updating them.
- Exercise caution when pausing and resuming distribution to avoid unintended consequences.

## Contributions

Contributions to enhance and optimize the EtherSplitter contract are welcome. Feel free to submit pull requests or open issues for improvements and bug fixes.

## License

This EtherSplitter contract is licensed under the MIT License. See the `LICENSE` file for details.
