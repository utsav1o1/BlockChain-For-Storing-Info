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

app.get('/users/:id', async (req, res) => {   // http://localhost:3000/users/1
    try {
        const id = req.params.id;
        const user = await contractInstance.getUser(id);
        let userData = {
            name: user[0],
            email: user[1]
        };
        res.send(userData);
    } catch (error) {
        res.status(500).send(error.message);
    }
});

app.get('/users', async (req, res) => {   // http://localhost:3000/users
    try {
        const allUsers = await contractInstance.getAllUsers();
        const users = allUsers.map(user => ({
            id: parseInt(user.id),
            name: user.name,
            email: user.email
        }));
        res.send(users);
    } catch (error) {
        res.status(500).send(error.message);
    }
});

app.post('/users', async (req, res) => {
    try {
        const { name, email } = req.body;
        const tx = await contractInstance.addUser(name, email);
        await tx.wait();
        res.json({ success: true });
    } catch (error) {
        res.status(500).send(error.message);
    }
});

app.get('/transactions/:id', async (req, res) => {   // http://localhost:3000/transactions/1
    try {
        const id = req.params.id;
        const transaction = await contractInstance.getTransaction(id);
        let transactionData = {
            buyerEmail: transaction[0],
            sellerEmail: transaction[1],
            buyerPoints: parseInt(transaction[2]),
            sellerPoints: parseInt(transaction[3]),
            action: transaction[4]
        };
        res.send(transactionData);
    } catch (error) {
        res.status(500).send(error.message);
    }
});

app.get('/transactions', async (req, res) => {   // http://localhost:3000/transactions
    try {
        const allTransactions = await contractInstance.getAllTransactions();
        const transactions = allTransactions.map(transaction => ({
            buyerEmail: transaction.buyerEmail,
            sellerEmail: transaction.sellerEmail,
            buyerPoints: parseInt(transaction.buyerPoints),
            sellerPoints: parseInt(transaction.sellerPoints),
            action: transaction.action
        }));
        res.send(transactions);
    } catch (error) {
        res.status(500).send(error.message);
    }
});

app.post('/transactions', async (req, res) => {
    try {
        const { buyerEmail, sellerEmail, buyerPoints, sellerPoints, action } = req.body;
        const tx = await contractInstance.addTransaction(buyerEmail, sellerEmail, buyerPoints, sellerPoints, action);
        await tx.wait();
        res.json({ success: true });
    } catch (error) {
        res.status(500).send(error.message);
    }
});

const port = 3000;
app.listen(port, () => {
    console.log("API server is listening on port 3000")
})
