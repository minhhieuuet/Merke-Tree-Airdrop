# Airdrop Project 
Test
```shell
node scripts/generator.js //To generate Merkle Root and tree_out.json
npx hardhat test
```
Deploy
1. Modify **scripts/airdrop.csv** file
2. Run **node scripts/generator.js** to generate Merkle Root and tree_out.json
3. Modify Merke Root and ERC20 token at **deploy.js**
4. Run npx hardhat run **scripts/deploy.js**