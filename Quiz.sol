// SPDX-License-Identifier: MIT
pragma solidity >0.8.0;

//this Smart Contract is for cryptobiz series demo purpose
// Hence, not optimized.
contract Quiz {
    struct Winner {
        uint8 qNo;
        string name;
    }
    struct Question {
        string qn;
        // Sha256 Hash  of answer
        bytes32 ans;
    }
    address public admin;
    mapping(address => Winner) public winners;
    mapping(uint8 => Question) public qns;

    //constructor
    constructor() {
        admin = msg.sender;
    }

    //modifiers
    modifier onlyAdmin() {
        require(
            msg.sender == admin,
            "This operation can only be performed by admin"
        );
        _;
    }
    //events
    event CorrectAnswer(address addr, uint8 qId);
    event WrongAnswer(address addr, uint8 qId);
    event WonIceCream(address addr, string name);
    event NewQnAdded(uint8 qId);

    //functions
    //Add new Question only if msg sender is admin
    function addQn(
        uint8 qId,
        string memory qn,
        bytes32 ans
    ) public onlyAdmin {
        qns[qId] = Question({qn: qn, ans: ans});
        emit NewQnAdded(qId);
    }

    //Answer Question
    //here we just check the response with answer
    function answerQn(string memory name,uint8 qNo, bytes32 res) public returns (bool) {
        if (res == qns[qNo].ans) {
            winners[msg.sender] = Winner({qNo: qNo,name:name });
            emit CorrectAnswer(msg.sender, qNo);
            return true;
        } else {
            emit WrongAnswer(msg.sender, qNo);
            return false;
        }
    }
}
