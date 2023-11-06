//SPDX-License-Identifier: UNLICENSED
pragma solidity >= 0.7.0 <0.9.0;
contract MarksManagmtSys{
    struct StudentStruct{
        uint ID;
        string fName;
        string lName;
        uint class;
    }
    address owner;
    
    uint public stdCount = 0;
    // event log(string, uint);
    StudentStruct[] public stdRecords;
    
    constructor() {
        owner=msg.sender;
    }

    function addNewRecords(uint _ID,string memory _fName,string memory _lName,uint _class) public {
        stdCount += 1;
        stdRecords.push(StudentStruct(_ID , _fName , _lName , _class));
    }

    receive() external payable {
        revert();
    }
}
