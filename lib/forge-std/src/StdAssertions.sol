// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

abstract contract StdAssertions {
    function assertTrue(bool condition) internal virtual {
        if (!condition) {
            revert("Assertion failed");
        }
    }

    function assertFalse(bool condition) internal virtual {
        if (condition) {
            revert("Assertion failed");
        }
    }

    function assertEq(bool a, bool b) internal virtual {
        if (a != b) {
            revert("Assertion failed");
        }
    }

    function assertEq(uint256 a, uint256 b) internal virtual {
        if (a != b) {
            revert("Assertion failed");
        }
    }

    function assertEq(int256 a, int256 b) internal virtual {
        if (a != b) {
            revert("Assertion failed");
        }
    }

    function assertEq(address a, address b) internal virtual {
        if (a != b) {
            revert("Assertion failed");
        }
    }

    function assertEq(bytes32 a, bytes32 b) internal virtual {
        if (a != b) {
            revert("Assertion failed");
        }
    }

    function assertEq(string memory a, string memory b) internal virtual {
        if (keccak256(bytes(a)) != keccak256(bytes(b))) {
            revert("Assertion failed");
        }
    }

    function assertEq(bytes memory a, bytes memory b) internal virtual {
        if (keccak256(a) != keccak256(b)) {
            revert("Assertion failed");
        }
    }

    function assertNotEq(bool a, bool b) internal virtual {
        if (a == b) {
            revert("Assertion failed");
        }
    }

    function assertNotEq(uint256 a, uint256 b) internal virtual {
        if (a == b) {
            revert("Assertion failed");
        }
    }

    function assertNotEq(address a, address b) internal virtual {
        if (a == b) {
            revert("Assertion failed");
        }
    }

    function assertGt(uint256 a, uint256 b) internal virtual {
        if (a <= b) {
            revert("Assertion failed");
        }
    }

    function assertGte(uint256 a, uint256 b) internal virtual {
        if (a < b) {
            revert("Assertion failed");
        }
    }

    function assertLt(uint256 a, uint256 b) internal virtual {
        if (a >= b) {
            revert("Assertion failed");
        }
    }

    function assertLte(uint256 a, uint256 b) internal virtual {
        if (a > b) {
            revert("Assertion failed");
        }
    }
}