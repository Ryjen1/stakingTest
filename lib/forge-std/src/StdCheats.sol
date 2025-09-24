// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

abstract contract StdCheats {
    
    function prank(address msgSender) internal {
        vm.prank(msgSender);
    }
    
    function startPrank(address msgSender) internal {
        vm.startPrank(msgSender);
    }
    
    function stopPrank() internal {
        vm.stopPrank();
    }
    
    function deal(address who, uint256 amount) internal {
        vm.deal(who, amount);
    }
    
    function expectRevert(bytes calldata revertData) internal {
        vm.expectRevert(revertData);
    }
    
    function expectRevert(bytes4 revertData) internal {
        vm.expectRevert(revertData);
    }
    
    function expectRevert() internal {
        vm.expectRevert();
    }
    
    function warp(uint256 timestamp) internal {
        vm.warp(timestamp);
    }
    
    function roll(uint256 blockNumber) internal {
        vm.roll(blockNumber);
    }
}