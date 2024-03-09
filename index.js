const express = require('express');
const ethers = require('ethers');
const dotenv = require('dotenv');

// Load environment variables
require('dotenv').config();
dotenv.config();

// API configuration
const API_URL = process.env.API_URL;
const PRIVATE_KEY = process.env.PRIVATE_KEY;
const contractAddress = process.env.CONTRACT_ADDRESS;

// Connect to provider and signer
const provider = new ethers.providers.JsonRpcProvider(API_URL);
const signer = new ethers.Wallet(PRIVATE_KEY, provider);

// Load contract ABI
const { abi } = require("./artifacts/contracts/ExInfo.sol/ExInfo.json");
const contractInstance = new ethers.Contract(contractAddress, abi, signer);

const app = express();
app.use(express.json());

app.post('/users', async (req, res) => {
    try {
        const { id, name, email } = req.body;
        const tx = await contractInstance.addUser(id ,name, email);
        await tx.wait();
        res.json({ hash: tx.hash });
    } catch (error) {
        res.status(500).send(error.message);
    }
});

app.post('/programs', async (req, res) => {
    try {
        const { id, name } = req.body;
        const tx = await contractInstance.addProgram(id , name);
        await tx.wait();
        res.json({ hash: tx.hash });
    } catch (error) {
        res.status(500).send(error.message);
    }
});

app.post('/transactions', async (req, res) => {
    try {
        const { userId, programId, points, action, refCode } = req.body;
        const tx = await contractInstance.addTransaction(userId, programId, points, action, refCode);
        await tx.wait();
        res.json({ hash: tx.hash });
    } catch (error) {
        res.status(500).send(error.message);
    }
});


const port = 3000;
app.listen(port, () => {
    console.log("API server is listening on port 3000")
})
