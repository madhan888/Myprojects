Pragma solidity ^0.7.3;

import './UnderlyingToken.sol';
import './LpToken.sol';
import './GovernanceToken.sol';

contract LiquidityPool is LpToken {

       mapping(address => uint) public checkpoints;
       UnderlyingToken public underlyingToken;
       GovernanceToken public governanceToken;
       uint constant public REWARD_PER_BLOCK=1;

       constructor(adress_underlyingToken,address_governanceToken){

           underlyingToken=UnderlyingToken(adress_underlyingToken);
           governanceToken=GovernanceToken(_governanceToken);
       }

       function deposit(uint amount) external{
           if(checkpoints[msg.sender]==0){
               checkpoints[msg.sender]=block.number;
           }

           __distributeRewards(msg.sender);
           underlyingToken.transferFrom(msg.sender,address(this).amount);
           _mint(msg.sender,amount);
       }

       function withdraw(uint amount) external{
           require(balanceOf(msg.sender)>=amount,'Not enough LP tokens');
           _distributeRewards(msg.sender);
           underlyingToken.transfer(msg.sender,amount);
           _burn(msg.sender,amount);
       }

       function _distributeRewards(address beneficiary) internal{
           uint checkpoint=checkpoints[beneficiary];
           if(block.number - checkpoint > 0) {
               uint distributionAmount = balanceof(beneficiary)*(block.number-checkpoint)*REWARD_PER_BLOCK;

               governanceToken.mint(beneficiary,distributionAmount);
               checkpoints[beneficiary]=block.number;
           }
       }



}