// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;

contract Vm {
    function prank(address) external {}
    function startPrank(address) external {}
    function stopPrank() external {}
    function warp(uint256) external {}
    function roll(uint256) external {}
    function deal(address, uint256) external {}
    function expectRevert(bytes calldata) external {}
    function expectRevert(bytes4) external {}
    function expectRevert() external {}
}