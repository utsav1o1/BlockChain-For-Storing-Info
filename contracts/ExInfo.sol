// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

pragma experimental ABIEncoderV2;

contract ExInfo {
  
    struct User {
        uint256 id;
        string name;
        string email;
    }
    
    struct Transaction {
        string buyerEmail;
        string sellerEmail;
        uint256 buyerPoints;
        uint256 sellerPoints;
        string action;
    }
    
    address owner;
    
    User public removeMe;
    
    mapping(uint256 => User) public users;
    mapping(uint256 => Transaction) public transactions;
    
    uint256 public userCount;
    uint256 public transactionCount;
    
    modifier onlyOwner {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }
    
    constructor() {
        owner = msg.sender;
    }
    
    function addUser(string memory _name, string memory _email) public onlyOwner {
        users[userCount] = User(userCount, _name, _email);
        userCount++;
    }
    
    function getUser(uint256 _userId) public view returns (string memory, string memory) {
        require(_userId < userCount, "User does not exist");
        return (users[_userId].name, users[_userId].email);
    }
    
    function getAllUsers() public view returns (User[] memory) {
        User[] memory allUsers = new User[](userCount);
        for (uint256 i = 0; i < userCount; i++) {
            allUsers[i] = users[i];
        }
        return allUsers;
    }
    
    function addTransaction(string memory _buyerEmail, string memory _sellerEmail, uint256 _buyerPoints, uint256 _sellerPoints, string memory _action) public onlyOwner {
        transactions[transactionCount] = Transaction(_buyerEmail, _sellerEmail, _buyerPoints, _sellerPoints, _action);
        transactionCount++;
    }
    
    function getTransaction(uint256 _transactionId) public view returns (string memory, string memory, uint256, uint256, string memory) {
        require(_transactionId < transactionCount, "Transaction does not exist");
        return (transactions[_transactionId].buyerEmail, transactions[_transactionId].sellerEmail, transactions[_transactionId].buyerPoints, transactions[_transactionId].sellerPoints, transactions[_transactionId].action);
    }
    
    function getAllTransactions() public view returns (Transaction[] memory) {
        Transaction[] memory allTransactions = new Transaction[](transactionCount);
        for (uint256 i = 0; i < transactionCount; i++) {
            allTransactions[i] = transactions[i];
        }
        return allTransactions;
    }
    
    // function updateProduct(uint256 _id, string memory _name, string memory _email) public onlyOwner {
    //     require(users[_id].id != 0, "User does not exist");
    //     users[_id].name = _name;
    //     users[_id].email = _email;
    // }
    
    // function deleteUser(uint256 _id) public onlyOwner {
    //     require(users[_id].id != 0, "User does not exist");
    //     delete users[_id];
    // }

}


// contract ExInfo {
//     struct User {
//         uint256 id;
//         string name;
//         string email;
//         uint256 points;
//     }

//     struct Transaction {
//         address buyerAddress;
//         address sellerAddress;
//         uint256 buyerPointsChange;
//         uint256 sellerPointsChange;
//         uint256 timestamp;
//         string action; // "credited", "redeemed", "traded"
//     }

//     mapping(address => User) public users;
//     User public userArray;
//     mapping(address => Transaction[]) public transactions;
//     Transaction[] public transactionsArray;

//     event TransactionAdded(
//         address indexed programAddress,
//         address buyerAddress,
//         address sellerAddress,
//         uint256 buyerPointsChange,
//         uint256 sellerPointsChange,
//         string action
//     );

//     function addUser(
//         uint256 id,
//         string memory name,
//         string memory email
//     ) public {
//         require(!userExists(msg.sender), "User already exists");
//         users[msg.sender] = User({id: id, name: name, email: email, points: 0});
//     }

//     function addTransaction(
//         address buyerAddress,
//         address sellerAddress,
//         uint256 buyerPointsChange,
//         uint256 sellerPointsChange,
//         string memory action
//     ) public {
//         require(
//             msg.sender == buyerAddress || msg.sender == sellerAddress,
//             "Unauthorized access"
//         );
//         require(isValidAction(action), "Invalid action");

//         if (
//             keccak256(abi.encodePacked(action)) ==
//             keccak256(abi.encodePacked("credited"))
//         ) {
//             users[buyerAddress].points += buyerPointsChange;
//         } else if (
//             keccak256(abi.encodePacked(action)) ==
//             keccak256(abi.encodePacked("redeemed"))
//         ) {
//             require(
//                 users[buyerAddress].points >= buyerPointsChange,
//                 "Insufficient points"
//             );
//             users[buyerAddress].points -= buyerPointsChange;
//         } else if (
//             keccak256(abi.encodePacked(action)) ==
//             keccak256(abi.encodePacked("traded"))
//         ) {
//             require(
//                 users[buyerAddress].points >= buyerPointsChange,
//                 "Insufficient points"
//             );
//             users[buyerAddress].points -= buyerPointsChange;
//             users[sellerAddress].points += sellerPointsChange;
//         }

//         transactions[msg.sender].push(
//             Transaction({
//                 buyerAddress: buyerAddress,
//                 sellerAddress: sellerAddress,
//                 buyerPointsChange: buyerPointsChange,
//                 sellerPointsChange: sellerPointsChange,
//                 timestamp: block.timestamp,
//                 action: action
//             })
//         );

//         emit TransactionAdded(
//             msg.sender,
//             buyerAddress,
//             sellerAddress,
//             buyerPointsChange,
//             sellerPointsChange,
//             action
//         );
//     }

//     function getTransactions(
//         address programAddress
//     ) public view returns (Transaction[] memory) {
//         return transactions[programAddress];
//     }

//     function getLatestTransaction(
//         address programAddress
//     ) public view returns (Transaction memory) {
//         Transaction[] memory programTransactions = transactions[programAddress];
//         require(
//             programTransactions.length > 0,
//             "No transactions for this program"
//         );
//         return programTransactions[programTransactions.length - 1];
//     }

//     function getUser(address userAddress) public view returns (User memory) {
//         return users[userAddress];
//     }

//     function userExists(address userAddress) public view returns (bool) {
//         return bytes(users[userAddress].name).length > 0;
//     }

//     function getAllUser() public view returns (User memory)
//     {
//         return userArray;
//     }

//     function getAllTransactions() public view returns (Transaction[] memory)
//     {
//         return transactionsArray;
//     }
   


//     function isValidAction(string memory action) internal pure returns (bool) {
//         return
//             keccak256(abi.encodePacked(action)) ==
//             keccak256(abi.encodePacked("credited")) ||
//             keccak256(abi.encodePacked(action)) ==
//             keccak256(abi.encodePacked("redeemed")) ||
//             keccak256(abi.encodePacked(action)) ==
//             keccak256(abi.encodePacked("traded"));
//     }
// }
