// SPDX-License-Identifier: MIT
pragma solidity 0.8.4; //Do not change the solidity version as it negativly impacts submission grading

import "hardhat/console.sol";
import "./ExampleExternalContract.sol";

contract Staker {
	ExampleExternalContract public exampleExternalContract;

  bool executed;
	bool openWithdraw;
  uint256 public deadline = block.timestamp + 72 hours;
	uint256 public constant threshold = 1 ether;

  mapping(address => uint) public balances;

	error StakeMustNotBeZero();
	error AddrZeroDetected();
	error CanNotExecute();
	error ThresholdMet();
	error NoStakingYet();
	error StakingDeadlineHasPasssed();
	error ExecutedAlready();
	error StakingOngoing();
  error StakingEnded();

	event Stake(address, uint256);
	event StakeWithdrawn(address);
  event Execute(uint256);

  modifier NotCompleted() {
    require(!exampleExternalContract.completed(), "Operation not allowed, contract already completed");
    _;
  }

	constructor(address exampleExternalContractAddress) {
		exampleExternalContract = ExampleExternalContract(
			exampleExternalContractAddress
		);
	}

	// Collect funds in a payable `stake()` function and track individual `balances` with a mapping:
	// (Make sure to add a `Stake(address,uint256)` event and emit it for the frontend `All Stakings` tab to display)
	function stake() public payable {
		if (msg.sender == address(0)) revert AddrZeroDetected();
		if (msg.value <= 0) revert StakeMustNotBeZero();
    if (block.timestamp > deadline) revert StakingEnded();
		if (executed) revert StakingDeadlineHasPasssed();

		balances[msg.sender] += msg.value;

		emit Stake(msg.sender, msg.value);
	}

	// After some `deadline` allow anyone to call an `execute()` function
	// If the deadline has passed and the threshold is met, it should call `exampleExternalContract.complete{value: address(this).balance}()`
	function execute() external NotCompleted{
		if (deadline > block.timestamp) revert CanNotExecute();
		if (executed) revert ExecutedAlready();

    if (address(this).balance >= threshold) {
      executed = true;
      exampleExternalContract.complete{value: address(this).balance}();
      emit Execute(address(this).balance);
    }
	}

	// If the `threshold` was not met, allow everyone to call a `withdraw()` function to withdraw their balance
	function withdraw() external NotCompleted {
		if (msg.sender == address(0)) revert AddrZeroDetected();
		if (address(this).balance >= threshold) revert ThresholdMet();
		if (block.timestamp < deadline) revert StakingOngoing();
		if (balances[msg.sender] == 0) revert NoStakingYet();
 
    uint _amtToWithdraw = balances[msg.sender];
		balances[msg.sender] = 0;

		payable(msg.sender).transfer(_amtToWithdraw);

		emit StakeWithdrawn(msg.sender);
	}

	// Add a `timeLeft()` view function that returns the time left before the deadline for the frontend
	function timeLeft() external view returns (uint256) {
		if (block.timestamp >= deadline) return 0;

		return (deadline - block.timestamp);
	}

	// Add the `receive()` special function that receives eth and calls stake()
	receive() external payable {
		if (executed) revert ExecutedAlready();
		stake();
	}
}