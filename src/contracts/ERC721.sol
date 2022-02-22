// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './ERC165.sol';
import './interfaces/IERC721.sol';
import './libraries/Counters.sol';
/*
    1. nft to point the address 
    2. keep track of the token ids. 
    3. keep track of token owner addresses to token ids
    4. keep track of how many tokens an onwer address has
    5. create an event that emits a Transfer log -contract address, where is is being minted to then id 
*/

contract ERC721 is ERC165, IERC721{
    using Counters for Counters.Counter;

    // event Transfer(
    //     address indexed from, 
    //     address indexed to, 
    //     uint256 indexed tokenId);

    // event Approval (
    //     address indexed owner, 
    //     address indexed approval, 
    //     uint256 indexed tokenId);

    //Mapping from token id to the owner
    mapping(uint256 => address) private _tokenOwner;
    
    //Mapping from owner to number of owned tokens
    mapping(address => Counters.Counter) private _OwnertokensCount;

    // Mapping from t token id to approved addresses
    mapping(uint256 => address) private _tokenApprovals;

    constructor(){
        _registerInterface(bytes4(
            keccak256('balanceOf(bytes4)')^
            keccak256('ownerOf(bytes4)')^
            keccak256('transferFrom(bytes4)')
        ));
    }


    function balanceOf(address _owner) public override view returns(uint256){
        require(_owner != address(0),"owner query for non-existent token"); 
        return _OwnertokensCount[_owner].current();
    }

    function ownerOf(uint256 _tokenId) public override view returns(address){
        address owner = _tokenOwner[_tokenId];
        return owner;
    }

    function _exists(uint256 tokenId) internal view returns(bool){
        address owner = _tokenOwner[tokenId];
        return owner != address(0); // not zero
    }

    // this function is not safe
    // any type of mathematics can be held to dubious standards
    function _mint(address to,uint256 tokenId) internal virtual{
        require(to != address(0),"REC721: minting to the zero address");   
        require (!_exists(tokenId));

        _tokenOwner[tokenId] = to;
        _OwnertokensCount[to].increment();  

        emit Transfer(address(0), to,tokenId);
    }

    // this function is not safe
    // any type of mathematics can be held to dubious standards
    function _transferFrom(address _from, address _to, uint256 _tokenId)  public {
        require(_to != address(0),"REC721: minting to the zero address");
        require(_from == ownerOf(_tokenId),"REC721: minting to the zero address");
        _OwnertokensCount[_from].decrement();
        _OwnertokensCount[_to].increment(); 
        _tokenOwner[_tokenId] = _to;
        emit Transfer(_from, _to,_tokenId);
    }

    function transferFrom(address _from, address _to, uint256 _tokenId) override public {
        // require(isApprovedOrOwner(msg.sender,_tokenId));
        _transferFrom(_from,_to,_tokenId);
    }
 
    // function approve(address _to, uint256 tokenId)public {
    //     address owner = ownerOf(tokenId);
    //     require(_to!= owner, 'Error - approval to current owner');
    //     require(msg.sender == owner,'Current caller is not the owner');
    //     _tokenApprovals[tokenId]= _to;
    //     emit Approval(owner, _to, tokenId);
    // }

    // function isApprovedOrOwner(address spender, uint256 tokenId) internal{
    //     require(_exists(tokenId), 'token does not exit');
    //     address owner = ownerOf(tokenId);
    //     return(spender == owner);
    // }

}
