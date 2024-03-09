# Sample Hardhat Project

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, and a script that deploys that contract.

1. Copy package json and run ```shell npm install ```
2. After make .env file and copy paste the below code
    API_URL = "https://volta-rpc.energyweb.org/"
    PRIVATE_KEY = "6dc05226cb9caf5d4ee550f180513566f22ec8fa9a6785cfd63d905f60dc95169869602478" //its the private key of metamask
    CONTRACT_ADDRESS = "0x9dD7C9d40645BC138f45F359e73561e14F039474" //its the address we get after we deploy the contract
3. Run ```shell npx hardhat ```
4. 

Try running some of the following tasks:

```shell
npm install 
npx hardhat help
npx hardhat test
REPORT_GAS=true npx hardhat test
npx hardhat node
npx hardhat run scripts/deploy.js
npx hardhat run --network volta scripts/deploy.js
node index.js
```
