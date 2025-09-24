// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "../src/Staking.sol";
import "./MockErc20.sol";

contract SimpleStakingTest {
    StakingRewards staking;
    MockERC20 stakingToken;
    MockERC20 rewardToken;

    address owner = address(0x1000);
    address bob = address(0x2000);
    address dso = address(0x3000);

    function setUp() public {
        vm.startPrank(owner);
        stakingToken = new MockERC20();
        rewardToken = new MockERC20();
        staking = new StakingRewards(address(stakingToken), address(rewardToken));
        vm.stopPrank();
    }

    function test_alwaysPass() public {
        assertEq(staking.owner(), owner, "Wrong owner set");
        assertEq(address(staking.stakingToken()), address(stakingToken), "Wrong staking token address");
        assertEq(address(staking.rewardsToken()), address(rewardToken), "Wrong reward token address");
        assertTrue(true);
    }

    function test_cannot_stake_amount0() public {
        deal(address(stakingToken), bob, 10e18);
        vm.startPrank(bob);
        stakingToken.approve(address(staking), type(uint256).max);

        vm.expectRevert("amount = 0");
        staking.stake(0);
        vm.stopPrank();
    }

    function test_can_stake_successfully() public {
        deal(address(stakingToken), bob, 10e18);
        vm.startPrank(bob);
        stakingToken.approve(address(staking), type(uint256).max);
        uint256 _totalSupplyBeforeStaking = staking.totalSupply();
        staking.stake(5e18);
        assertEq(staking.balanceOf(bob), 5e18, "Amounts do not match");
        assertEq(staking.totalSupply(), _totalSupplyBeforeStaking + 5e18, "totalsupply didnt update correctly");
    }

    function test_cannot_withdraw_amount0() public {
        vm.prank(bob);
        vm.expectRevert("amount = 0");
        staking.withdraw(0);
    }

    function test_can_withdraw_deposited_amount() public {
        test_can_stake_successfully();

        uint256 userStakebefore = staking.balanceOf(bob);
        uint256 totalSupplyBefore = staking.totalSupply();
        staking.withdraw(2e18);
        assertEq(staking.balanceOf(bob), userStakebefore - 2e18, "Balance didnt update correctly");
        assertLt(staking.totalSupply(), totalSupplyBefore, "total supply didnt update correctly");
    }

    function test_notify_Rewards() public {
        vm.expectRevert("not authorized");
        staking.setRewardsDuration(1 weeks);

        vm.prank(owner);
        staking.setRewardsDuration(1 weeks);
        assertEq(staking.duration(), 1 weeks, "duration not updated correctly");

        vm.warp(block.timestamp + 200);
        deal(address(rewardToken), owner, 100 ether);
        vm.startPrank(owner);
        rewardToken.transfer(address(staking), 100 ether);

        vm.expectRevert("reward rate = 0");
        staking.notifyRewardAmount(1);

        vm.expectRevert("reward amount > balance");
        staking.notifyRewardAmount(200 ether);

        staking.notifyRewardAmount(100 ether);
        assertEq(staking.rewardRate(), uint256(100 ether)/uint256(1 weeks));
        assertEq(staking.finishAt(), uint256(block.timestamp) + uint256(1 weeks));
        assertEq(staking.updatedAt(), block.timestamp);

        vm.expectRevert("reward duration not finished");
        staking.setRewardsDuration(1 weeks);
    }

    // Additional tests for 100% coverage
    function test_getReward() public {
        // First stake some tokens
        deal(address(stakingToken), bob, 10e18);
        vm.startPrank(bob);
        stakingToken.approve(address(staking), type(uint256).max);
        staking.stake(5e18);
        vm.stopPrank();

        // Set up rewards
        vm.prank(owner);
        staking.setRewardsDuration(1 weeks);

        deal(address(rewardToken), owner, 100 ether);
        vm.startPrank(owner);
        rewardToken.transfer(address(staking), 100 ether);
        staking.notifyRewardAmount(100 ether);
        vm.stopPrank();

        // Fast forward time
        vm.warp(block.timestamp + 1 weeks);

        // Get reward
        vm.prank(bob);
        staking.getReward();

        // Check that reward was transferred
        assertGt(rewardToken.balanceOf(bob), 0, "No reward received");
    }

    function test_earned() public {
        // First stake some tokens
        deal(address(stakingToken), bob, 10e18);
        vm.startPrank(bob);
        stakingToken.approve(address(staking), type(uint256).max);
        staking.stake(5e18);
        vm.stopPrank();

        // Set up rewards
        vm.prank(owner);
        staking.setRewardsDuration(1 weeks);

        deal(address(rewardToken), owner, 100 ether);
        vm.startPrank(owner);
        rewardToken.transfer(address(staking), 100 ether);
        staking.notifyRewardAmount(100 ether);
        vm.stopPrank();

        // Check earned amount
        uint256 earnedAmount = staking.earned(bob);
        assertGt(earnedAmount, 0, "No rewards earned");
    }

    function test_rewardPerToken() public {
        // First stake some tokens
        deal(address(stakingToken), bob, 10e18);
        vm.startPrank(bob);
        stakingToken.approve(address(staking), type(uint256).max);
        staking.stake(5e18);
        vm.stopPrank();

        // Set up rewards
        vm.prank(owner);
        staking.setRewardsDuration(1 weeks);

        deal(address(rewardToken), owner, 100 ether);
        vm.startPrank(owner);
        rewardToken.transfer(address(staking), 100 ether);
        staking.notifyRewardAmount(100 ether);
        vm.stopPrank();

        // Check reward per token
        uint256 rewardPerToken = staking.rewardPerToken();
        assertGt(rewardPerToken, 0, "No reward per token");
    }

    function test_lastTimeRewardApplicable() public {
        vm.prank(owner);
        staking.setRewardsDuration(1 weeks);

        deal(address(rewardToken), owner, 100 ether);
        vm.startPrank(owner);
        rewardToken.transfer(address(staking), 100 ether);
        staking.notifyRewardAmount(100 ether);
        vm.stopPrank();

        uint256 lastTime = staking.lastTimeRewardApplicable();
        assertEq(lastTime, block.timestamp, "Wrong last time reward applicable");
    }

    function test_multiple_users_staking() public {
        address alice = address(0x4000);

        // Bob stakes
        deal(address(stakingToken), bob, 10e18);
        vm.startPrank(bob);
        stakingToken.approve(address(staking), type(uint256).max);
        staking.stake(5e18);
        vm.stopPrank();

        // Alice stakes
        deal(address(stakingToken), alice, 10e18);
        vm.startPrank(alice);
        stakingToken.approve(address(staking), type(uint256).max);
        staking.stake(3e18);
        vm.stopPrank();

        // Check balances
        assertEq(staking.balanceOf(bob), 5e18, "Bob balance incorrect");
        assertEq(staking.balanceOf(alice), 3e18, "Alice balance incorrect");
        assertEq(staking.totalSupply(), 8e18, "Total supply incorrect");
    }

    function test_cannot_set_duration_zero() public {
        vm.prank(owner);
        vm.expectRevert("reward duration = 0");
        staking.setRewardsDuration(0);
    }

    function test_cannot_notify_zero_amount() public {
        vm.prank(owner);
        vm.expectRevert("amount = 0");
        staking.notifyRewardAmount(0);
    }

    function test_stake_withdraw_multiple_times() public {
        deal(address(stakingToken), bob, 20e18);
        vm.startPrank(bob);
        stakingToken.approve(address(staking), type(uint256).max);

        // Stake multiple times
        staking.stake(5e18);
        staking.stake(3e18);
        assertEq(staking.balanceOf(bob), 8e18, "Balance after multiple stakes incorrect");

        // Withdraw multiple times
        staking.withdraw(2e18);
        staking.withdraw(1e18);
        assertEq(staking.balanceOf(bob), 5e18, "Balance after multiple withdrawals incorrect");
        vm.stopPrank();
    }

    function test_reward_calculation_over_time() public {
        // Stake tokens
        deal(address(stakingToken), bob, 10e18);
        vm.startPrank(bob);
        stakingToken.approve(address(staking), type(uint256).max);
        staking.stake(10e18);
        vm.stopPrank();

        // Set up rewards
        vm.prank(owner);
        staking.setRewardsDuration(1 weeks);

        deal(address(rewardToken), owner, 100 ether);
        vm.startPrank(owner);
        rewardToken.transfer(address(staking), 100 ether);
        staking.notifyRewardAmount(100 ether);
        vm.stopPrank();

        // Check earned at different times
        uint256 earned1 = staking.earned(bob);

        vm.warp(block.timestamp + 3 days);
        uint256 earned2 = staking.earned(bob);

        vm.warp(block.timestamp + 3 days);
        uint256 earned3 = staking.earned(bob);

        assert(earned2 > earned1, "Earned should increase over time");
        assert(earned3 > earned2, "Earned should increase over time");
    }

    // Helper functions
    function assertTrue(bool condition) internal pure {
        require(condition, "Test failed");
    }

    function assertEq(uint256 a, uint256 b, string memory message) internal pure {
        require(a == b, message);
    }

    function assertEq(address a, address b, string memory message) internal pure {
        require(a == b, message);
    }

    function assertGt(uint256 a, uint256 b, string memory message) internal pure {
        require(a > b, message);
    }

    function assertLt(uint256 a, uint256 b, string memory message) internal pure {
        require(a < b, message);
    }

    // Mock VM functions
    function vm() internal pure returns (Vm) {
        return Vm(address(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D));
    }
}

interface Vm {
    function startPrank(address) external;
    function stopPrank() external;
    function warp(uint256) external;
    function deal(address, uint256) external;
    function expectRevert(bytes calldata) external;
}