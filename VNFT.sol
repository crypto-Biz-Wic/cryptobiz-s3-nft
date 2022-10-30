//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract VNFT is ERC721URIStorage, Ownable {

    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor()
        ERC721("v4zha", "v4z")
    {
        //
    }

    function mintNFT(address recipient_, string memory tokenURI_)
        public
        onlyOwner
        returns (uint)
    {
        _tokenIds.increment();

        uint newItemId = _tokenIds.current();
        _mint(recipient_, newItemId);
        _setTokenURI(newItemId, tokenURI_);

        return newItemId;
    }
}
