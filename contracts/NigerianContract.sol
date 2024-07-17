//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import  "./NgnNft.sol";
import "./NgnToken.sol";

contract NigerianContract {
NgnNft public ngnNft; 
NgnToken public  ngnToken; 

    constructor(address _ngnNft, address _ngnToken){
        ngnNft = NgnNft(_ngnNft);
        ngnToken = NgnToken(_ngnToken);
    }

    mapping(address => bool) public eligibleCitizens;

    function mintAndBecomeEligible(address owner) public {
         require(msg.sender == address(this), "Only the contract owner can mint NFTs");
         require(eligibleCitizens[owner], "You are not eligible for funds");
             ngnNft.mint(owner);
             eligibleCitizens[owner] = true;
         emit NftMinted(owner); 
}



    function withdrawFunds(address owner) public {
        require(eligibleCitizens[owner], "You are not eligible for funds"); 
        require( ngnNft.balanceOf(owner) == 0, "You have already withdrawn funds");
       
        ngnToken.transfer(owner, 1000); 

        

    }
}