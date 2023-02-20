// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/*
    ''''''''''''''''''''''''''''''''''''''''''''''''''
    ''''''''''''''''''''''''''''''''''''''''''''''''''
    ''''''''''''''''''''''''''''''''''''''''''''''''''
    ''''''''''''''''''''''''''''''''''''''''''''''''''
    ''''''''''''''''''''''''''''''''''''''''''''''''''
    ''''''''''''''''''''''''''''',''''''''''''''''''''
    ''''''''''''''''''''''''''.;okx;.'''''''''''''''''
    ''''''''''''''''''''''''..'ok00:.'''''''''''''''''
    '''''''''''''''.'';::;,'..cxkXx'''''''''''''''''''
    ''''''''''.''',lx0KNXOdlodxdOKc.''''''''''''''''''
    ''''''''''''''lXWMMMMMMWNNxdNXxl:,''''''''''''''''
    '''''''''''''',lONWMMMMMWNKXMMMWN0xl;'''''''''''''
    ''''''''''''''..':ox0XWMMMMMMMMMMMMW0l''''''''''''
    '''''''''.'',:ll:,'.';codxkO0KXXNNXK0o,.''''''''''
    ''''''''''''.':oO0Oxdolc:::::clodxxkx:''''''''''''
    '''''''''''''''',dXMMMWWNNNXXXXNNNXkc'''''''''''''
    ''''''''''''''''''c0WMMWNXXK0Okdoc;'''''''''''''''
    ''''''''''''''''''.,xXWN0Oxl,''..'''''''''''''''''
    '''''''''''''''''''.'coc;,'.''''''.'''''''''''''''
    '''''''''''''''''''''..'''''''''''''''''''''''''''
    ''''''''''''''''''''''''''''''''''''''''''''''''''
    ''''''''''''''''''''''''''''''''''''''''''''''''''
    ''''''''''''''''''''''''''''''''''''''''''''''''''
    ''''''''''''''''''''''''''''''''''''''''''''''''''
    ''''''''''''''''''''''''''''''''''''''''''''''''''
*/

/// @title Spintop NFT
/// @author @takez0_o
/// @notice This contract is being used to gift Spintop NFTs to users.
/// @dev Owner can mint with no limit/restrictions.
contract SpintopNFT is ERC721, Ownable {
    constructor() ERC721("Spintop NFT", "SPINTOP") {}

    function mint(address to, uint256 tokenId) external onlyOwner {
        _safeMint(to, tokenId);
    }
}
