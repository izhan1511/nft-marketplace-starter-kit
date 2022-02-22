// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


library SafeMath {
    //build func to perform safe math oprations

    function add(uint256 a, uint256 b) internal pure returns(uint256){
        uint256 r = a+b;
        require(r>=a,'SafeMath: Addition Overflow');
        return r;
    }

    function sub(uint256 a, uint256 b) internal pure returns(uint256){
        require(b<=a,'SafeMath: subtraction Overflow');
        uint256 r = a-b;
        return r;
    }

    function mul(uint256 a, uint256 b) internal pure returns(uint256){
        //gas optimization 
        if (a==0){
            return 0;
        }
        uint256 r = a*b;
        require(r/a==b,'SafeMath: multiplication Overflow');
        return r;
    }

    function divide(uint256 a, uint256 b) internal pure returns(uint256){
        require(b>0,'SafeMath: division by zero');
        uint256 r = a/b;
        return r;
    }

    function divideByModulo(uint256 a, uint256 b) internal pure returns(uint256){
        require(b!=0,'SafeMath: divideByModulo Overflow');
        return a%b;
    }
    
}