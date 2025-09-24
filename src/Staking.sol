// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import "lib/openzeppelin-contracts/contracts/access/Ownable.sol";

contract StakingRewards is ERC20, Ownable {
    IERC20 public immutable rewardsToken;
    IERC20 public immutable stakingToken;

    uint256 public duration; // Duration of rewards to be paid out
    uint256 public finishAt; // Timestamp of when the rewards finish
    uint256 public updatedAt; // Timestamp of when the reward variables were last updated
    uint256 public rewardRate; // Reward to be paid out per second
    uint256 public rewardPerTokenStored; // Sum of (reward rate * dt * 1e18 / total supply)

    mapping(address => uint256) public userRewardPerTokenPaid; // User address => userRewardPerTokenPaid
    mapping(address => uint256) public rewards; // User address => rewards to be claimed

    uint256 private constant PRECISION = 1e18;

    event Staked(address indexed user, uint256 amount);
    event Withdrawn(address indexed user, uint256 amount);
    event RewardPaid(address indexed user, uint256 reward);
    event RewardAdded(uint256 reward);

    constructor(address _stakingToken, address _rewardsToken)
        ERC20("Staking Token", "STK")
        Ownable(msg.sender)
    {
        stakingToken = IERC20(_stakingToken);
        rewardsToken = IERC20(_rewardsToken);
    }

    modifier updateReward(address _account) {
        rewardPerTokenStored = rewardPerToken();
        updatedAt = lastTimeRewardApplicable();

        if (_account != address(0)) {
            rewards[_account] = earned(_account);
            userRewardPerTokenPaid[_account] = rewardPerTokenStored;
        }
        _;
    }

    function lastTimeRewardApplicable() public view returns (uint256) {
        return block.timestamp < finishAt ? block.timestamp : finishAt;
    }

    function rewardPerToken() public view returns (uint256) {
        if (totalSupply() == 0) {
            return rewardPerTokenStored;
        }

        return rewardPerTokenStored + (
            (rewardRate * (lastTimeRewardApplicable() - updatedAt) * PRECISION) / totalSupply()
        );
    }

    function earned(address _account) public view returns (uint256) {
        uint256 currentRewardPerToken = rewardPerToken();
        uint256 userRewardPerToken = userRewardPerTokenPaid[_account];

        return (balanceOf(_account) * (currentRewardPerToken - userRewardPerToken)) / PRECISION + rewards[_account];
    }

    function stake(uint256 _amount) external updateReward(msg.sender) {
        require(_amount > 0, "amount = 0");

        _mint(msg.sender, _amount);
        stakingToken.transferFrom(msg.sender, address(this), _amount);

        emit Staked(msg.sender, _amount);
    }

    function withdraw(uint256 _amount) external updateReward(msg.sender) {
        require(_amount > 0, "amount = 0");

        _burn(msg.sender, _amount);
        stakingToken.transfer(msg.sender, _amount);

        emit Withdrawn(msg.sender, _amount);
    }

    function getReward() external updateReward(msg.sender) {
        uint256 reward = rewards[msg.sender];
        if (reward > 0) {
            rewards[msg.sender] = 0;
            rewardsToken.transfer(msg.sender, reward);

            emit RewardPaid(msg.sender, reward);
        }
    }

    function setRewardsDuration(uint256 _duration) external onlyOwner {
        require(finishAt < block.timestamp, "reward duration not finished");
        require(_duration > 0, "reward duration = 0");

        duration = _duration;
    }

    function notifyRewardAmount(uint256 _amount) external onlyOwner updateReward(address(0)) {
        require(_amount > 0, "amount = 0");
        require(rewardsToken.balanceOf(address(this)) >= _amount, "reward amount > balance");

        if (block.timestamp >= finishAt) {
            rewardRate = _amount / duration;
        } else {
            uint256 remainingRewards = (finishAt - block.timestamp) * rewardRate;
            rewardRate = (remainingRewards + _amount) / duration;
        }

        require(rewardRate > 0, "reward rate = 0");
        require(rewardRate <= rewardsToken.balanceOf(address(this)) / duration, "reward rate > balance");

        finishAt = block.timestamp + duration;
        updatedAt = block.timestamp;

        emit RewardAdded(_amount);
    }
}