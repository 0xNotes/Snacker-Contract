// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";


contract Snacker {
    // uint256 public number;

    // function setNumber(uint256 newNumber) public {
    //     number = newNumber;
    // }

    // function increment() public {
    //     number++;
    // }

    address burn = 0x000000000000000000000000000000000000dEaD;


    


    
    // function SnackApproval(address _contentNft, uint256 _contentId, address _styleNft, uint256 _styleId) public {
    //     IERC721(_contentNft).approve(address(this), _contentId);
    //     IERC721(_styleNft).approve(address(this), _styleId);
    // }

    function Snack(address _contentNft, uint256 _contentId, address _styleNft, uint256 _styleId) public {
        IERC721(_contentNft).transferFrom(msg.sender, burn, _contentId);
        IERC721(_styleNft).transferFrom(msg.sender, burn, _styleId);
        
    }
}
