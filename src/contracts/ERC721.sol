// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
    1. nft to point the address 
    2. keep track of the token ids. 
    3. keep track of token owner addresses to token ids
    4. keep track of how many tokens an onwer address has
    5. create an event that emits a trasnfer log -contract address, where is is being minted to then id 
*/

contract ERC721{

    event Trasnfer(
        address indexed from, 
        address indexed to, 
        uint256 indexed tokenId);

    event Approval (
        address indexed owner, 
        address indexed approval, 
        uint256 indexed tokenId);

    //Mapping from token id to the owner
    mapping(uint256 => address) private _tokenOwner;
    
    //Mapping from owner to number of owned tokens
    mapping(address => uint) private _OwnertokensCount;

    // Mapping from t token id to approved addresses
    mapping(uint256 => address) private _tokenApprovals;

    function balanceOf(address _owner) public view returns(uint256){
        require(_owner != address(0),"owner query for non-existent token"); 
        return _OwnertokensCount[_owner];
    }

    function ownerOf(uint256 _tokenId) public view returns(address){
        address owner = _tokenOwner[_tokenId];
        return owner;
    }

    function _exists(uint256 tokenId) internal view returns(bool){
        address owner = _tokenOwner[tokenId];
        return owner != address(0); // not zero
    }

    function _mint(address to,uint256 tokenId) internal virtual{
        require(to != address(0),"REC721: minting to the zero address");   
        require (!_exists(tokenId));
        _tokenOwner[tokenId] = to;
        _OwnertokensCount[to]++;

        emit Trasnfer(address(0), to,tokenId);
    }

    function _transferFrom(address _from, address _to, uint256 _tokenId) internal {
        require(_to != address(0),"REC721: minting to the zero address");
        require(_from == ownerOf(_tokenId),"REC721: minting to the zero address");
        _OwnertokensCount[_from]--;
        _OwnertokensCount[_to]++;
        _tokenOwner[_tokenId] = _to;
        emit Trasnfer(_from, _to,_tokenId);
    }

    function transferFrom(address _from, address _to, uint256 _tokenId) public {
        require(isApprovedOrOwner(msg.sender,_tokenId));
        _transferFrom(_from,_to,_tokenId);
    }
 
    function approve(address _to, uint256 tokenId)public {
        address owner = ownerOf(tokenId);
        require(_to!= owner, 'Error - approval to current owner');
        require(msg.sender == owner,'Current caller is not the owner');
        _tokenApprovals[tokenId]= _to;
        emit Approval(owner, _to, tokenId);
    }

    function isApprovedOrOwner(address spender, uint256 tokenId) internal{
        require(_exists(tokenId), 'token does not exit');
        address owner = ownerOf(tokenId);
        return(spender == owner);
    }

}
