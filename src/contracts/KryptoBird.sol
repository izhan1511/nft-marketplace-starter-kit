// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './ERC721Connector.sol';


contract KryptoBird is ERC721Connector{

    //array to store our nfts
    string [] public kryptoBird;
    mapping(string =>bool) krytoBirdzExists;

    function mint(string memory _kryptoBird) public{
        require(!krytoBirdzExists[_kryptoBird],'Error, krytoBirdz not exist');
        // uint _id = KryptoBird.push(_kryptoBird); this is deprecated
        kryptoBird.push(_kryptoBird);
        uint _id =kryptoBird.length -1;
        _mint(msg.sender,_id);

        krytoBirdzExists[_kryptoBird] = true;
    }
    constructor() ERC721Connector('KryptoBird','KBIRDZ') {

    }
}