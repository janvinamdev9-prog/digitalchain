// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title DigitalChain
 * @dev A simple blockchain-based record system that lets users store, verify, 
 * and retrieve digital records on-chain. Demonstrates basic Solidity functions.
 */
contract DigitalChain {
    address public owner;
    uint256 public recordCount;

    struct Record {
        uint256 id;
        string dataHash;
        address creator;
        uint256 timestamp;
    }

    mapping(uint256 => Record) public records;

    event RecordAdded(uint256 indexed id, string dataHash, address indexed creator);
    event RecordVerified(uint256 indexed id, string dataHash, address indexed verifier);

    constructor() {
        owner = msg.sender;
    }

    /**
     * @notice Add a new record to the blockchain.
     * @param _dataHash A unique identifier (e.g., IPFS hash or SHA-256) for the digital asset.
     */
    function addRecord(string calldata _dataHash) external {
        recordCount++;
        records[recordCount] = Record(recordCount, _dataHash, msg.sender, block.timestamp);
        emit RecordAdded(recordCount, _dataHash, msg.sender);
    }

    /**
     * @notice Verify an existing record by ID.
     * @param _id The ID of the record to verify.
     */
    function verifyRecord(uint256 _id) external view returns (Record memory) {
        require(_id > 0 && _id <= recordCount, "Record does not exist");
        return records[_id];
    }

    /**
     * @notice Get the total number of stored records.
     */
    function getRecordCount() external view returns (uint256) {
        return recordCount;
    }
}
