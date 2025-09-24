// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "../src/Staking.sol";
import "./MockErc20.sol";

// Simple test runner that doesn't depend on forge-std
contract SimpleTestRunner {
    StakingRewards staking;
    MockERC20 stakingToken;
    MockERC20 rewardToken;

    address owner = address(0x1000);
    address bob = address(0x2000);
    address alice = address(0x3000);

    bool public allTestsPassed = true;
    string public lastError = "";

    function runAllTests() public returns (bool) {
        try this.testBasicSetup() { } catch { allTestsPassed = false; lastError = "testBasicSetup failed"; }
        try this.testStakeWithdraw() { } catch { allTestsPassed = false; lastError = "testStakeWithdraw failed"; }
        try this.testRewardSystem() { } catch { allTestsPassed = false; lastError = "testRewardSystem failed"; }
        try this.testMultipleUsers() { } catch { allTestsPassed = false; lastError = "testMultipleUsers failed"; }
        try this.testEdgeCases() { } catch { allTestsPassed = false; lastError = "testEdgeCases failed"; }
        try this.testTimeBasedRewards() { } catch { allTestsPassed = false; lastError = "testTimeBasedRewards failed"; }

        return allTestsPassed;
    }

    function testBasicSetup() public {
        // Setup
        stakingToken = new MockERC20();
        rewardToken = new MockERC20();
        staking = new StakingRewards(address(stakingToken), address(rewardToken));

        // Test basic properties
        require(staking.owner() == address(this), "Wrong owner");
        require(address(staking.stakingToken()) == address(stakingToken), "Wrong staking token");
        require(address(staking.rewardsToken()) == address(rewardToken), "Wrong reward token");
        require(staking.totalSupply() == 0, "Initial supply should be 0");
    }

    function testStakeWithdraw() public {
        // Give tokens to bob
        stakingToken.transfer(bob, 10e18);

        // Bob stakes
        vm.prank(bob);
        stakingToken.approve(address(staking), 5e18);
        vm.prank(bob);
        staking.stake(5e18);

        require(staking.balanceOf(bob) == 5e18, "Bob balance incorrect");
        require(staking.totalSupply() == 5e18, "Total supply incorrect");

        // Bob withdraws
        vm.prank(bob);
        staking.withdraw(2e18);

        require(staking.balanceOf(bob) == 3e18, "Bob balance after withdraw incorrect");
        require(staking.totalSupply() == 3e18, "Total supply after withdraw incorrect");
    }

    function testRewardSystem() public {
        // Setup rewards
        staking.setRewardsDuration(1 weeks);

        // Add reward tokens
        rewardToken.transfer(address(staking), 100 ether);
        staking.notifyRewardAmount(100 ether);

        require(staking.rewardRate() == 100 ether / 1 weeks, "Reward rate incorrect");
        require(staking.duration() == 1 weeks, "Duration incorrect");
    }

    function testMultipleUsers() public {
        // Alice stakes
        stakingToken.transfer(alice, 10e18);
        vm.prank(alice);
        stakingToken.approve(address(staking), 3e18);
        vm.prank(alice);
        staking.stake(3e18);

        require(staking.balanceOf(alice) == 3e18, "Alice balance incorrect");
        require(staking.totalSupply() == 6e18, "Total supply with multiple users incorrect");
    }

    function testEdgeCases() public {
        // Test zero amount staking
        vm.prank(bob);
        try staking.stake(0) { require(false, "Should revert on zero stake"); } catch { }

        // Test zero amount withdrawal
        vm.prank(bob);
        try staking.withdraw(0) { require(false, "Should revert on zero withdraw"); } catch { }

        // Test zero duration
        try staking.setRewardsDuration(0) { require(false, "Should revert on zero duration"); } catch { }

        // Test zero reward amount
        try staking.notifyRewardAmount(0) { require(false, "Should revert on zero reward amount"); } catch { }
    }

    function testTimeBasedRewards() public {
        // Setup rewards
        staking.setRewardsDuration(1 weeks);
        rewardToken.transfer(address(staking), 100 ether);
        staking.notifyRewardAmount(100 ether);

        // Check earned rewards over time
        uint256 earned1 = staking.earned(bob);

        // Simulate time passing
        vm.warp(block.timestamp + 3 days);
        uint256 earned2 = staking.earned(bob);

        require(earned2 > earned1, "Earned rewards should increase over time");
    }

    // Helper functions
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