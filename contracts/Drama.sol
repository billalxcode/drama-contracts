// SPDX-License-Identifier: MIT
pragma solidity ^0.8;
import "@openzeppelin/contracts/access/Ownable.sol";

contract Drama is Ownable {
    event NewDrama(uint256 drama_id, string title, string description, address indexed author);
    event AddedTopic(string[] topics, uint256 drama_id, address indexed author);
    event DeletedDrama(uint256 drama_id, string reason);

    struct DramaStruct {
        string title;
        string description;
        address author;
        string[] topics;
        uint256 createdAt;
    }

    uint256 lastDramaId;
    uint256 lastTopicId;
    mapping (uint256 => DramaStruct) public dramaLists;

    string[] private defaultTopics;

    constructor() Ownable(msg.sender) {
        lastDramaId = 0;
        lastTopicId = 0;
    }

    function addDrama(
        string memory _title,
        string memory _description
    ) public returns (uint256) {
        DramaStruct memory newDrama = DramaStruct({
            title: _title,
            description: _description,
            author: msg.sender,
            topics: defaultTopics,
            createdAt: block.timestamp
        });
        
        lastDramaId++;
        dramaLists[lastDramaId] = newDrama;
        
        emit NewDrama(lastDramaId, _title, _description, msg.sender);
        return lastDramaId;
    }

    function deleteDrama(
        uint256 dramaId,
        string memory reason
    ) public {
        DramaStruct memory drama = dramaLists[dramaId];

        require(drama.createdAt > 0, "No drama found at database");
        require(drama.author == msg.sender, "Only author can delete drama");

        delete dramaLists[dramaId];

        emit DeletedDrama(dramaId, reason);
    }

    function addTopic(
        string[] calldata _topics,
        uint256 dramaId
    ) public {
        DramaStruct storage drama = dramaLists[dramaId];

        require(drama.createdAt > 0, "No drama found at databases");
        require(drama.author == msg.sender, "Only author can add new topic");

        for (uint256 _topicId = 0; _topicId < drama.topics.length; _topicId++) {
           drama.topics.push(_topics[_topicId]);
        }
        dramaLists[dramaId] = drama;

        emit AddedTopic(_topics, dramaId, msg.sender);
    }
}