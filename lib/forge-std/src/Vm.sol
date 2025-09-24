
// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;

interface Vm {
    // Performs the next smart contract call with the given `msg.sender`
    function prank(address) external;

    // Performs all subsequent smart contract calls with the given `msg.sender`
    function startPrank(address) external;

    // Stop performing smart contract calls with the given `msg.sender`
    function stopPrank() external;

    // Set block.timestamp
    function warp(uint256) external;

    // Set block.height
    function roll(uint256) external;

    // Loads a storage slot from an address
    function load(address, bytes32) external returns (bytes32);

    // Stores a value to an address' storage slot
    function store(address, bytes32, bytes32) external;

    // Signs data, (privateKey, digest) => (v, r, s)
    function sign(uint256, bytes32) external returns (uint8, bytes32, bytes32);

    // Gets address for a given private key, (privateKey) => (address)
    function addr(uint256) external returns (address);

    // Gets the label for a specific address
    function getLabel(address) external returns (string memory);

    // Sets the label for an address
    function setLabel(address, string calldata) external;

    // Performs a foreign function call via terminal
    function ffi(string[] calldata) external returns (bytes memory);

    // Reads environment variables, (name) => (value)
    function envBool(string calldata) external returns (bool);
    function envUint(string calldata) external returns (uint256);
    function envInt(string calldata) external returns (int256);
    function envAddress(string calldata) external returns (address);
    function envBytes32(string calldata) external returns (bytes32);
    function envString(string calldata) external returns (string memory);
    function envBytes(string calldata) external returns (bytes memory);

    // Sets environment variables
    function setEnv(string calldata, string calldata) external;

    // Record all storage reads and writes
    function record() external;

    // Gets all accessed reads and write slot from a recording session, for a given address
    function accesses(address) external returns (bytes32[] memory reads, bytes32[] memory writes);

    // Record all account accesses
    function recordLogs() external;

    // Gets all accessed logs from a recording session, for a given address
    function getRecordedLogs() external returns (Log[] memory);

    // Prepare an expected log with (bool checkTopic1, bool checkTopic2, bool checkTopic3, bool checkData).
    function expectEmit(bool, bool, bool, bool) external;

    // Mocks a call to an address, returning specified data.
    function mockCall(address, bytes calldata, bytes calldata) external;

    // Mocks a call to an address with a specific msg.value, returning specified data.
    function mockCall(address, uint256, bytes calldata, bytes calldata) external;

    // Clears all mocked calls
    function clearMockedCalls() external;

    // Expect a call to an address with the specified calldata, and optional value.
    function expectCall(address, bytes calldata) external;
    function expectCall(address, uint256, bytes calldata) external;

    // When fuzzing, generate new inputs if conditional not met
    function assume(bool) external;

    // Using the address that calls the test contract, has the next call (at this call depth only) create a transaction that can later be signed and sent onchain
    function broadcast() external;

    // Has the next call (at this call depth only) create a transaction with the address provided as the caller that can later be signed and sent onchain
    function broadcast(address) external;

    // Using the address that calls the test contract, has all subsequent calls (at this call depth only) create transactions that can later be signed and sent onchain
    function startBroadcast() external;

    // Has all subsequent calls (at this call depth only) create transactions with the address provided as the caller that can later be signed and sent onchain
    function startBroadcast(address) external;

    // Stops collecting onchain transactions
    function stopBroadcast() external;

    // Get the path of the current project root
    function projectRoot() external returns (string memory);

    // Read the content of a file. Takes in the relative path to the file
    function readFile(string calldata) external returns (string memory);

    // Read the content of a file at a specific line. Takes in the relative path to the file and the line number
    function readLine(string calldata) external returns (string memory);

    // Write to a file. Takes in the relative path to the file and the content to write
    function writeFile(string calldata, string calldata) external;

    // Write to a file at a specific line. Takes in the relative path to the file, the line number, and the content to write
    function writeLine(string calldata, uint256, string calldata) external;

    // Read the content of a directory. Takes in the relative path to the directory
    function readDir(string calldata) external returns (string[] memory);

    // Read the content of a directory at a specific depth. Takes in the relative path to the directory and the depth
    function readDir(string calldata, uint256) external returns (string[] memory);

    // Remove a file from the filesystem. Takes in the relative path to the file
    function removeFile(string calldata) external;

    // Remove a directory from the filesystem. Takes in the relative path to the directory
    function removeDir(string calldata) external;

    // Copy a file from one path to another. Takes in the source path and the destination path
    function copyFile(string calldata, string calldata) external;

    // Create a new directory. Takes in the relative path to the directory
    function createDir(string calldata) external;

    // Check if a file exists. Takes in the relative path to the file
    function exists(string calldata) external returns (bool);

    // Check if a directory exists. Takes in the relative path to the directory
    function isDir(string calldata) external returns (bool);

    // Check if a path is a file. Takes in the relative path to the path
    function isFile(string calldata) external returns (bool);

    // Get the current working directory
    function getcwd() external returns (string memory);

    // Change the current working directory
    function chdir(string calldata) external;

    // Get the current timestamp
    function timestamp() external returns (uint256);

    // Get the current block number
    function blockNumber() external returns (uint256);

    // Get the current chain id
    function chainId() external returns (uint256);

    // Get the current gas price
    function gasPrice() external returns (uint256);

    // Get the current tx.origin
    function txOrigin() external returns (address);

    // Get the current msg.sender
    function msgSender() external returns (address);

    // Get the current msg.value
    function msgValue() external returns (uint256);

    // Get the current tx.gasprice
    function txGasPrice() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
    function blockhash(uint256) external returns (bytes32);

    // Get the current block.timestamp
    function blocktimestamp() external returns (uint256);

    // Get the current block.chainid
    function chainid() external returns (uint256);

    // Get the current block.coinbase
    function coinbase() external returns (address);

    // Get the current block.difficulty
    function difficulty() external returns (uint256);

    // Get the current block.prevrandao
    function prevrandao() external returns (bytes32);

    // Get the current block.basefee
    function basefee() external returns (uint256);

    // Get the current block.gaslimit
    function gaslimit() external returns (uint256);

    // Get the current block.number
