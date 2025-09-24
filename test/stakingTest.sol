// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.26;

import  "forge-std/Test.sol";
import {StakingRewards, IERC20} from "../src/Staking.sol";
import {MockERC20} from "./MockErc20.sol";

contract StakingTest is Test {
    StakingRewards staking;
    MockERC20 stakingToken;
    MockERC20 rewardToken;

    address owner = makeAddr("owner");
    address bob = makeAddr("bob");
    address dso = makeAddr("dso");

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
        // start prank to assume user is making subsequent calls
        vm.startPrank(bob);
        IERC20(address(stakingToken)).approve(address(staking), type(uint256).max);

        // we are expecting a revert if we deposit/stake zero
        vm.expectRevert("amount = 0");
        staking.stake(0);
        vm.stopPrank();
    }

    function test_can_stake_successfully() public {
        deal(address(stakingToken), bob, 10e18);
        // start prank to assume user is making subsequent calls
        vm.startPrank(bob);
        IERC20(address(stakingToken)).approve(address(staking), type(uint256).max);
        uint256 _totalSupplyBeforeStaking = staking.totalSupply();
        staking.stake(5e18);
        assertEq(staking.balanceOf(bob), 5e18, "Amounts do not match");
        assertEq(staking.totalSupply(), _totalSupplyBeforeStaking + 5e18, "totalsupply didnt update correctly");
    }

    function  test_cannot_withdraw_amount0() public {
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
        // check that it reverts if non owner tried to set duration
        vm.expectRevert("not authorized");
        staking.setRewardsDuration(1 weeks);

        // simulate owner calls setReward successfully
        vm.prank(owner);
        staking.setRewardsDuration(1 weeks);
        assertEq(staking.duration(), 1 weeks, "duration not updated correctly");
        // log block.timestamp
        console.log("current time", block.timestamp);
        // move time foward
        vm.warp(block.timestamp + 200);
        // notify rewards
        deal(address(rewardToken), owner, 100 ether);
        vm.startPrank(owner);
        IERC20(address(rewardToken)).transfer(address(staking), 100 ether);

        // trigger revert
        vm.expectRevert("reward rate = 0");
        staking.notifyRewardAmount(1);

        // trigger second revert
        vm.expectRevert("reward amount > balance");
        staking.notifyRewardAmount(200 ether);

        // trigger first type of flow success
        staking.notifyRewardAmount(100 ether);
        assertEq(staking.rewardRate(), uint256(100 ether)/uint256(1 weeks));
        assertEq(staking.finishAt(), uint256(block.timestamp) + uint256(1 weeks));
        assertEq(staking.updatedAt(), block.timestamp);

        // trigger setRewards distribution revert
        vm.expectRevert("reward duration not finished");
        staking.setRewardsDuration(1 weeks);

     }

     // Additional tests for 100% coverage
     function test_getReward() public {
         // First stake some tokens
         deal(address(stakingToken), bob, 10e18);
         vm.startPrank(bob);
         IERC20(address(stakingToken)).approve(address(staking), type(uint256).max);
         staking.stake(5e18);
         vm.stopPrank();

         // Set up rewards
         vm.prank(owner);
         staking.setRewardsDuration(1 weeks);

         deal(address(rewardToken), owner, 100 ether);
         vm.startPrank(owner);
         IERC20(address(rewardToken)).transfer(address(staking), 100 ether);
         staking.notifyRewardAmount(100 ether);
         vm.stopPrank();

         // Fast forward time
         vm.warp(block.timestamp + 1 weeks);

         // Get reward
         vm.prank(bob);
         staking.getReward();

         // Check that reward was transferred
         assertGt(IERC20(address(rewardToken)).balanceOf(bob), 0, "No reward received");
     }

     function test_earned() public {
         // First stake some tokens
         deal(address(stakingToken), bob, 10e18);
         vm.startPrank(bob);
         IERC20(address(stakingToken)).approve(address(staking), type(uint256).max);
         staking.stake(5e18);
         vm.stopPrank();

         // Set up rewards
         vm.prank(owner);
         staking.setRewardsDuration(1 weeks);

         deal(address(rewardToken), owner, 100 ether);
         vm.startPrank(owner);
         IERC20(address(rewardToken)).transfer(address(staking), 100 ether);
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
         IERC20(address(stakingToken)).approve(address(staking), type(uint256).max);
         staking.stake(5e18);
         vm.stopPrank();

         // Set up rewards
         vm.prank(owner);
         staking.setRewardsDuration(1 weeks);

         deal(address(rewardToken), owner, 100 ether);
         vm.startPrank(owner);
         IERC20(address(rewardToken)).transfer(address(staking), 100 ether);
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
         IERC20(address(rewardToken)).transfer(address(staking), 100 ether);
         staking.notifyRewardAmount(100 ether);
         vm.stopPrank();

         uint256 lastTime = staking.lastTimeRewardApplicable();
         assertEq(lastTime, block.timestamp, "Wrong last time reward applicable");
     }

     function test_multiple_users_staking() public {
         address alice = makeAddr("alice");

         // Bob stakes
         deal(address(stakingToken), bob, 10e18);
         vm.startPrank(bob);
         IERC20(address(stakingToken)).approve(address(staking), type(uint256).max);
         staking.stake(5e18);
         vm.stopPrank();

         // Alice stakes
         deal(address(stakingToken), alice, 10e18);
         vm.startPrank(alice);
         IERC20(address(stakingToken)).approve(address(staking), type(uint256).max);
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
         IERC20(address(stakingToken)).approve(address(staking), type(uint256).max);

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
         IERC20(address(stakingToken)).approve(address(staking), type(uint256).max);
         staking.stake(10e18);
         vm.stopPrank();

         // Set up rewards
         vm.prank(owner);
         staking.setRewardsDuration(1 weeks);

         deal(address(rewardToken), owner, 100 ether);
         vm.startPrank(owner);
         IERC20(address(rewardToken)).transfer(address(staking), 100 ether);
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

     function test_transfer_ownership() public {
         address newOwner = makeAddr("newOwner");

         vm.prank(owner);
         staking.transferOwnership(newOwner);

         assertEq(staking.owner(), newOwner, "Ownership not transferred");
     }

     function test_renounce_ownership() public {
         vm.prank(owner);
         staking.renounceOwnership();

         assertEq(staking.owner(), address(0), "Ownership not renounced");
     }

     function test_cannot_transfer_ownership_non_owner() public {
         address newOwner = makeAddr("newOwner");

         vm.prank(bob);
         vm.expectRevert("not authorized");
         staking.transferOwnership(newOwner);
     }

     function test_cannot_renounce_ownership_non_owner() public {
         vm.prank(bob);
         vm.expectRevert("not authorized");
         staking.renounceOwnership();
     }

     function test_cannot_transfer_to_zero_address() public {
         vm.prank(owner);
         vm.expectRevert("Ownable: new owner is the zero address");
         staking.transferOwnership(address(0));
     }

     function test_staking_token_transfer_from() public {
         deal(address(stakingToken), bob, 10e18);
         vm.startPrank(bob);
         IERC20(address(stakingToken)).approve(address(staking), type(uint256).max);
         staking.stake(5e18);
         vm.stopPrank();

         // Check that staking contract received the tokens
         assertEq(stakingToken.balanceOf(address(staking)), 5e18, "Staking contract didn't receive tokens");
         assertEq(stakingToken.balanceOf(bob), 5e18, "Bob didn't have correct remaining balance");
     }

     function test_withdraw_transfers_back() public {
         deal(address(stakingToken), bob, 10e18);
         vm.startPrank(bob);
         IERC20(address(stakingToken)).approve(address(staking), type(uint256).max);
         staking.stake(5e18);

         uint256 balanceBefore = stakingToken.balanceOf(bob);
         staking.withdraw(3e18);
         uint256 balanceAfter = stakingToken.balanceOf(bob);

         assertEq(balanceAfter, balanceBefore + 3e18, "Tokens not transferred back correctly");
         vm.stopPrank();
     }

     function test_getReward_zero_balance() public {
         // Try to get reward without staking
         vm.prank(bob);
         staking.getReward();

         // Should not revert and should not transfer any tokens
         assertEq(rewardToken.balanceOf(bob), 0, "Should not receive any reward tokens");
     }

     function test_earned_zero_stake() public {
         // Check earned without staking
         uint256 earnedAmount = staking.earned(bob);
         assertEq(earnedAmount, 0, "Should not have earned anything without staking");
     }

     function test_rewardPerToken_zero_supply() public {
         // Check reward per token with zero supply
         uint256 rewardPerToken = staking.rewardPerToken();
         assertEq(rewardPerToken, 0, "Should be zero with no stakers");
     }

     function test_lastTimeRewardApplicable_no_rewards() public {
         // Check last time reward applicable with no rewards set
         uint256 lastTime = staking.lastTimeRewardApplicable();
         assertEq(lastTime, block.timestamp, "Should return current timestamp");
     }

     function test_finishAt_after_duration() public {
         vm.prank(owner);
         staking.setRewardsDuration(1 weeks);

         deal(address(rewardToken), owner, 100 ether);
         vm.startPrank(owner);
         IERC20(address(rewardToken)).transfer(address(staking), 100 ether);
         staking.notifyRewardAmount(100 ether);
         vm.stopPrank();

         assertEq(staking.finishAt(), block.timestamp + 1 weeks, "Finish time incorrect");
     }

     function test_updatedAt_after_notify() public {
         vm.prank(owner);
         staking.setRewardsDuration(1 weeks);

         deal(address(rewardToken), owner, 100 ether);
         vm.startPrank(owner);
         IERC20(address(rewardToken)).transfer(address(staking), 100 ether);
         staking.notifyRewardAmount(100 ether);
         vm.stopPrank();

         assertEq(staking.updatedAt(), block.timestamp, "Updated time incorrect");
     }

     function test_rewardRate_calculation() public {
         vm.prank(owner);
         staking.setRewardsDuration(1 weeks);

         deal(address(rewardToken), owner, 100 ether);
         vm.startPrank(owner);
         IERC20(address(rewardToken)).transfer(address(staking), 100 ether);
         staking.notifyRewardAmount(100 ether);
         vm.stopPrank();

         assertEq(staking.rewardRate(), 100 ether / 1 weeks, "Reward rate calculation incorrect");
     }

     function test_duration_storage() public {
         vm.prank(owner);
         staking.setRewardsDuration(2 weeks);

         assertEq(staking.duration(), 2 weeks, "Duration not stored correctly");
     }

     function test_stakingToken_address() public {
         assertEq(address(staking.stakingToken()), address(stakingToken), "Staking token address incorrect");
     }

     function test_rewardsToken_address() public {
         assertEq(address(staking.rewardsToken()), address(rewardToken), "Rewards token address incorrect");
     }

     function test_name_and_symbol() public {
         assertEq(staking.name(), "Staking Token", "Name incorrect");
         assertEq(staking.symbol(), "STK", "Symbol incorrect");
     }

     function test_decimals() public {
         assertEq(staking.decimals(), 18, "Decimals incorrect");
     }


}