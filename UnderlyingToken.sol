pragma solidity ^0.7.3;

import '@openzeppelin/contracts/ERC/ERC20.sol';

contract UnderlyingToken is ERC20{
    constructor() ERC20('Lp Token','LTK'){}

     function faucet(address to,uint amount) external{
        _mint(to,amount);
     }

}
