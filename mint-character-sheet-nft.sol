// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

//Character Sheet Minter Contract
contract CharacterSheetNFTs is ERC721, Ownable {
    using Counters for Counters.Counter;
    using Strings for uint256;

    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("Ceptor Club Character Sheet NFTs -test04", "CCCSt04") {}

    function safeMint(address to) public onlyOwner {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        tokenURI(tokenId);
    }

    //Values and Traits
    string public characterClass;
    string public race;
    string public background;
    //string public alignment;  //Stack too deep.
    string public strength;
    string public dexterity;
    string public constitution;
    string public intelligence;
    string public wisdom;
    string public charisma;
    string public description;
    string public imgURL;
    
	function setTraits (string memory _characterClass, string memory _race, string memory _background/*, string memory _alignment*/) public onlyOwner{
        characterClass = _characterClass;
        race = _race;
        background = _background;
        //alignment = _alignment;
        imgURL = "https://minelaborsimulator.com/nft/helmet-platinum.png";
        
        strength = "12";
        dexterity = "15";
        constitution = "18";
        intelligence = "8";
        wisdom = "9";
        charisma = "15";
        description = "Demo character sheet for test net. Early build.";
        safeMint(msg.sender);
    }
    function tokenURI(uint256 tokenId)
        public
        view
        override
        returns (string memory)
    {
        bytes memory dataURI = abi.encodePacked(
            '{',
                '"name": "Ceptor Club Character Sheet #', tokenId.toString(), '"'',',
                '"description": ''"', description, '"',',',
                '"external_url": "https://doncodes.com/ceptor-club"'',',
                '"image": ''"', imgURL, '"',',',
                '"attributes":',
                    '[',
                        '{',
                            '"trait_type": "Character Class"'',', 
                            '"value": ''"', characterClass, '"',
                        '}'',',
                        '{',
                            '"trait_type": "Race"'',', 
                            '"value": ''"', race, '"',
                        '}'',',
                         '{',
                            '"trait_type": "Background"'',', 
                            '"value": ''"', background, '"',
                        '}'',',
                        '{',
                            '"trait_type": "Strength"'',',
                            '"max_value": 30'',', 
                            '"value": ', strength,
                        '}'',',
                        '{',
                            '"trait_type": "Dexterity"'',',
                            '"max_value": 30'',', 
                            '"value": ', dexterity,
                        '}'',',
                        '{',
                            '"trait_type": "Constitution"'',',
                            '"max_value": 30'',', 
                            '"value": ', constitution,
                        '}'',',
                        '{',
                            '"trait_type": "Intelligence"'',',
                            '"max_value": 30'',', 
                            '"value": ', intelligence,
                        '}'',',
                        '{',
                            '"trait_type": "Wisdom"'',',
                            '"max_value": 30'',', 
                            '"value": ', wisdom,
                        '}'',',
                        '{',
                            '"trait_type": "Charisma"'',', 
                            '"max_value": 30'',', 
                            '"value": ', charisma,
                        '}',
                    ']',
            '}'
        );
        return string(
            abi.encodePacked(
                "data:application/json;base64,",
                Base64.encode(dataURI)
            )
        );
    }
}