pragma solidity ^0.8.0;

contract BloodBank {
    address public owner;
    
    struct BloodStock {
        uint8 bloodGroup;  // 1 for A+, 2 for A-, 3 for B+, and so on
        string location;
        uint stock;
    }

    BloodStock[] public bloodStocks;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    function addBloodStock(uint8 _bloodGroup, string memory _location, uint _stock) public onlyOwner {
        bloodStocks.push(BloodStock(_bloodGroup, _location, _stock));
    }

    function getBloodStockByGroup(uint8 _bloodGroup) public view returns (uint) {
        uint totalStock = 0;
        for (uint i = 0; i < bloodStocks.length; i++) {
            if (bloodStocks[i].bloodGroup == _bloodGroup) {
                totalStock += bloodStocks[i].stock;
            }
        }
        return totalStock;
    }

    function getBloodStockByLocation(string memory _location) public view returns (BloodStock[] memory) {
        BloodStock[] memory locationStock;
        for (uint i = 0; i < bloodStocks.length; i++) {
            if (keccak256(abi.encodePacked(bloodStocks[i].location)) == keccak256(abi.encodePacked(_location))) {
                locationStock.push(bloodStocks[i]);
            }
        }
        return locationStock;
    }

    function updateBloodStock(uint8 _bloodGroup, string memory _location, uint _newStock) public onlyOwner {
        for (uint i = 0; i < bloodStocks.length; i++) {
            if (bloodStocks[i].bloodGroup == _bloodGroup && keccak256(abi.encodePacked(bloodStocks[i].location)) == keccak256(abi.encodePacked(_location))) {
                bloodStocks[i].stock = _newStock;
                break;
            }
        }
    }
}
