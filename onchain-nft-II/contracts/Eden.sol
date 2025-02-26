// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

contract Eden is ERC721 {
    uint256 private _tokenIdCounter;

    constructor() ERC721('Eden', 'EDEN') {}

    function mint() public {
        _safeMint(msg.sender, _tokenIdCounter);
        _tokenIdCounter++;
    }

    function tokenURI(uint256 tokenId) public pure override returns (string memory) {
        require(tokenId == 0, 'Token ID not found');

        string memory svg = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 800 600" width="800" height="600" style="background-color: #87CEEB;">'
        '<!-- Sky -->'
        '<rect width="800" height="600" fill="#87CEEB" />'
        '<!-- Sun -->'
        '<circle cx="700" cy="100" r="50" fill="#FFD700" />'
        '<!-- Ground -->'
        '<rect x="0" y="400" width="800" height="200" fill="#228B22" />'
        '<!-- River -->'
        '<path d="M 400 400 Q 450 350 500 400 T 600 400" fill="none" stroke="#1E90FF" stroke-width="20" />'
        '<path d="M 400 400 Q 450 450 500 400 T 600 400" fill="none" stroke="#1E90FF" stroke-width="20" />'
        '<!-- Trees -->'
        '<g transform="translate(100, 300)">'
        '<rect x="0" y="0" width="20" height="100" fill="#8B4513" />'
        '<circle cx="10" cy="0" r="50" fill="#006400" />'
        '</g>'
        '<g transform="translate(300, 320)">'
        '<rect x="0" y="0" width="20" height="80" fill="#8B4513" />'
        '<circle cx="10" cy="0" r="40" fill="#006400" />'
        '</g>'
        '<g transform="translate(500, 310)">'
        '<rect x="0" y="0" width="20" height="90" fill="#8B4513" />'
        '<circle cx="10" cy="0" r="45" fill="#006400" />'
        '</g>'
        '<g transform="translate(700, 300)">'
        '<rect x="0" y="0" width="20" height="100" fill="#8B4513" />'
        '<circle cx="10" cy="0" r="50" fill="#006400" />'
        '</g>'
        '<!-- Adam and Eve -->'
        '<g transform="translate(350, 450)">'
        '<!-- Adam -->'
        '<circle cx="0" cy="0" r="15" fill="#FFDAB9" />'
        '<rect x="-5" y="15" width="10" height="30" fill="#0000FF" />'
        '<!-- Eve -->'
        '<circle cx="40" cy="0" r="15" fill="#FFDAB9" />'
        '<rect x="35" y="15" width="10" height="30" fill="#FF69B4" />'
        '</g>'
        '<!-- Serpent -->'
        '<path d="M 450 450 Q 470 430 490 450 T 530 450" fill="none" stroke="#32CD32" stroke-width="5" />'
        '<circle cx="530" cy="450" r="5" fill="#32CD32" />'
        '</svg>';

        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "Garden of Eden",',
                        '"description": "A depiction of the Garden of Eden as an NFT.",',
                        '"image": "data:image/svg+xml;base64,',
                        Base64.encode(bytes(svg)),
                        '"}'
                    )
                )
            )
        );

        return string(abi.encodePacked('data:application/json;base64,', json));
    }
}