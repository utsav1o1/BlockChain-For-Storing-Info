// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

pragma experimental ABIEncoderV2;

contract ExInfo {
  
    struct User {
        uint256 id;
        string name;
        string email;
    }

    struct Program {
        uint256 id;
        string name;
    }
    
    struct Transaction {
        User user;       // this should be linked with the user id
        Program program;    // this should be linked with program id 
        uint256 points;
        string action;
        string refCode;
    }
    
    address public owner;
    
    mapping(uint256 => User) public users;
    mapping(uint256 => Program) public programs;
    mapping(uint256 => Transaction) public transactions;
    uint256 public transactionCount;
    
    modifier onlyOwner {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }
    
    constructor() {
        owner = msg.sender;
    }
    
    function addUser(uint256 _id, string memory _name, string memory _email) public onlyOwner {
        users[_id] = User(_id, _name, _email);
    }

    function addProgram(uint256 _id, string memory _name) public onlyOwner {
        programs[_id] = Program(_id, _name);
    }
  
    function addTransaction(uint256 _userId, uint256 _programId, uint256 _points, string memory _action, string memory _refCode) public onlyOwner {
        transactionCount++;
        transactions[transactionCount] = Transaction(users[_userId], programs[_programId], _points, _action, _refCode);
    }
}
