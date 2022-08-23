pragma solidity ^0.7.3;

import'@openzeppelin/contracts/token/ERC20/IERC20.sol';
import './Fl.sol';
import './FlashloanUser.sol';

contract FlashloanUser is IFlashloanUser{
    function startFlashloan(address flashloan,uint amount,address token) external {
        FlashloanProvider(flashloan).executeFlashLoan(
            address(this),amount, token, bytes('') );
           
    }
    function  flashloanCallback(
        uint amount,address token,byets memory data ) override external {
            
        }
}