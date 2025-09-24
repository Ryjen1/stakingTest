// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "../src/Staking.sol";
import "./MockErc20.sol";

// Standalone test that doesn't depend on forge-std
contract StandaloneStakingTest {
    StakingRewards public staking;
    MockERC20 public stakingToken;
    MockERC20 public rewardToken;

    address public owner = address(0x1000);
    address public bob = address(0x2000);
    address public alice = address(0x3000);

    // Test results
    bool public testsPassed = true;
    string public lastError = "";

    constructor() {
        // Setup contracts
        stakingToken = new MockERC20();
        rewardToken = new MockERC20();
        staking = new StakingRewards(address(stakingToken), address(rewardToken));
    }

    function runAllTests() external returns (bool) {
        try this.testBasicSetup() { } catch Error(string memory reason) { testsPassed = false; lastError = reason; }
        try this.testStaking() { } catch Error(string memory reason) { testsPassed = false; lastError = reason; }
        try this.testWithdrawals() { } catch Error(string memory reason) { testsPassed = false; lastError = reason; }
        try this.testRewards() { } catch Error(string memory reason) { testsPassed = false; lastError = reason; }
        try this.testMultipleUsers() { } catch Error(string memory reason) { testsPassed = false; lastError = reason; }
        try this.testEdgeCases() { } catch Error(string memory reason) { testsPassed = false; lastError = reason; }

        return testsPassed;
    }

    function testBasicSetup() external {
        require(staking.owner() == address(this), "Wrong owner");
        require(address(staking.stakingToken()) == address(stakingToken), "Wrong staking token");
        require(address(staking.rewardsToken()) == address(rewardToken), "Wrong reward token");
        require(staking.totalSupply() == 0, "Initial supply should be 0");
        require(keccak256(bytes(staking.name())) == keccak256(bytes("Staking Token")), "Wrong name");
        require(keccak256(bytes(staking.symbol())) == keccak256(bytes("STK")), "Wrong symbol");
        require(staking.decimals() == 18, "Wrong decimals");
    }

    function testStaking() external {
        // Give tokens to bob
        stakingToken.transfer(bob, 10e18);

        // Bob approves and stakes
        vm.prank(bob);
        stakingToken.approve(address(staking), 5e18);

        vm.prank(bob);
        staking.stake(5e18);

        require(staking.balanceOf(bob) == 5e18, "Bob balance incorrect");
        require(staking.totalSupply() == 5e18, "Total supply incorrect");
        require(stakingToken.balanceOf(address(staking)) == 5e18, "Contract didn't receive tokens");
    }

    function testWithdrawals() external {
        // Bob withdraws
        vm.prank(bob);
        staking.withdraw(2e18);

        require(staking.balanceOf(bob) == 3e18, "Bob balance after withdraw incorrect");
        require(staking.totalSupply() == 3e18, "Total supply after withdraw incorrect");
        require(stakingToken.balanceOf(bob) == 8e18, "Bob didn't receive tokens back");
    }

    function testRewards() external {
        // Setup rewards
        staking.setRewardsDuration(1 weeks);

        // Add reward tokens
        rewardToken.transfer(address(staking), 100 ether);
        staking.notifyRewardAmount(100 ether);

        require(staking.rewardRate() == 100 ether / 1 weeks, "Reward rate incorrect");
        require(staking.duration() == 1 weeks, "Duration incorrect");
        require(staking.finishAt() == block.timestamp + 1 weeks, "Finish time incorrect");
    }

    function testMultipleUsers() external {
        // Alice stakes
        stakingToken.transfer(alice, 10e18);
        vm.prank(alice);
        stakingToken.approve(address(staking), 3e18);

        vm.prank(alice);
        staking.stake(3e18);

        require(staking.balanceOf(alice) == 3e18, "Alice balance incorrect");
        require(staking.totalSupply() == 6e18, "Total supply with multiple users incorrect");
    }

    function testEdgeCases() external {
        // Test zero amount staking
        vm.prank(bob);
        try staking.stake(0) { revert("Should revert on zero stake"); } catch { }

        // Test zero amount withdrawal
        vm.prank(bob);
        try staking.withdraw(0) { revert("Should revert on zero withdraw"); } catch { }

        // Test zero duration
        try staking.setRewardsDuration(0) { revert("Should revert on zero duration"); } catch { }

        // Test zero reward amount
        try staking.notifyRewardAmount(0) { revert("Should revert on zero reward amount"); } catch { }
    }

    function testRewardClaiming() external {
        // Setup rewards
        staking.setRewardsDuration(1 weeks);
        rewardToken.transfer(address(staking), 100 ether);
        staking.notifyRewardAmount(100 ether);

        // Fast forward time
        vm.warp(block.timestamp + 1 weeks);

        // Get reward
        vm.prank(bob);
        staking.getReward();

        require(rewardToken.balanceOf(bob) > 0, "No reward received");
    }

    function testRewardCalculation() external {
        // Setup rewards
        staking.setRewardsDuration(1 weeks);
        rewardToken.transfer(address(staking), 100 ether);
        staking.notifyRewardAmount(100 ether);

        uint256 earned1 = staking.earned(bob);

        // Fast forward time
        vm.warp(block.timestamp + 3 days);
        uint256 earned2 = staking.earned(bob);

        require(earned2 > earned1, "Earned rewards should increase over time");
    }

    // Helper function to simulate VM functions
    function vm() internal pure returns (Vm) {
        return Vm(address(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D));
    }

    receive() external payable {}
}

interface Vm {
    function prank(address) external;
    function warp(uint256) external;
    function deal(address, uint256) external;
    function expectRevert(bytes calldata) external;
}