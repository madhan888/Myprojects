pragma solidity ^0.7.3;

interface FlashLoanUser{
    function flashloanCallback(uint amount, address token , bytes memory data) external;
    }