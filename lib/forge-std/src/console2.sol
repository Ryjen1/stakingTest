// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

library console2 {
    address constant CONSOLE_ADDRESS = address(0x000000000000000000636F6E736F6C652E6C6F67);

    function log(string memory p0, string memory p1) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,string)", p0, p1));
    }

    function log(string memory p0, bool p1) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,bool)", p0, p1));
    }

    function log(string memory p0, address p1) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,address)", p0, p1));
    }

    function log(string memory p0, uint256 p1) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,uint256)", p0, p1));
    }

    function _sendLogPayload(bytes memory payload) private view {
        address consoleAddress = CONSOLE_ADDRESS;
        assembly {
            let r := staticcall(gas(), consoleAddress, add(payload, 32), mload(payload), 0, 0)
        }
    }
}