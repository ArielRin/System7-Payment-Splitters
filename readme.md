
# EtherSplitter Contract README

## What is the EtherSplitter?

The EtherSplitter is like a special wallet that can share money among different people. It works with Ethereum, which is a type of digital money.

## How does it work?

1. **Setting it up:**
   - We first decide who the EtherSplitter will send money to. We call these people "wallets."
   - We also decide how much money each wallet should get. We call this the "ratio."

2. **Receiving Money:**
   - The EtherSplitter can receive money (Ether) from people. It just collects the money for now and doesn't share it immediately.

3. **Sharing Money:**
   - When the owner decides, they can press a button (a special function called `distributeEther`).
   - When they press this button, the EtherSplitter takes all the collected money and shares it among the wallets according to the ratios we set.

4. **Pausing and Resuming:**
   - If there's a reason to stop sharing money temporarily, the owner can press another button (a function called `toggleDistributionPause`). This stops the sharing process.
   - When everything is okay again, they can press the button again to start sharing.

5. **Changing Wallets and Ratios:**
   - If we want to change who gets the money and how much they get, we can tell the owner, and they can update the information by pressing another button (a function called `updateWalletsAndRatios`).

## Important Notes:

- **Owner:**
  - There's someone in charge of the EtherSplitter, and we call them the "owner." They decide when to share money and can make changes to the setup.

- **Buttons (Functions):**
  - The EtherSplitter has special buttons (functions) that the owner can press to make it do different things, like sharing money, pausing, and updating the setup.

- **Money (Ether):**
  - In this world, we use a special kind of money called Ether. It's like coins and bills but digital.

That's it! The EtherSplitter helps share money in a fair and controlled way among different people. If you have any questions or want to learn more, just ask the owner!
