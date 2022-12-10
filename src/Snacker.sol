// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";


contract Snacker is ERC721, ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    string uri = "";
    address admin = address(2);

    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("Snacker", "SNK") {}
    address public burn = 0x000000000000000000000000000000000000dEaD;
    mapping(address => uint) public burnCount;



    function Snack(address _contentNft, uint256 _contentId, address _styleNft, uint256 _styleId, address to) public {
        IERC721(_contentNft).transferFrom(msg.sender, burn, _contentId);
        IERC721(_styleNft).transferFrom(msg.sender, burn, _styleId);

        burnCount[_contentNft] = burnCount[_contentNft] + 1;
        burnCount[_styleNft] = burnCount[_styleNft] + 1;

        //This is where the NFT needs to be generated from external adapter
        //The resulting ipfs link should be given back to the _setTokenUri or something

        uint256 tokenId = _tokenIdCounter.current();

        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }



    // The following functions are overrides required by Solidity.

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }
}




