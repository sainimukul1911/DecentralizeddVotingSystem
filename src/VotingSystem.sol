// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract VotingSystem {
    error VotingSystem__InsufficientBalance();
    error VotingSystem__InsufficientAccountBalance();
    mapping (string => uint256) private proposals;
    string[] private proposalsList;
    mapping (address => uint256) private balance;

    event ProposalAdded(string indexed proposal);
    event ProposalVoted(string indexed proposal, uint256 indexed votes);

    constructor (string[] memory _proposalsList) {
        for(uint i =0; i< _proposalsList.length ; i++){
            proposalsList.push(_proposalsList[i]);
        }
    }
    
    function addProposal(string memory proposal) external payable{
        if(balance[msg.sender] < 0.001 ether){
            revert VotingSystem__InsufficientAccountBalance();
        }
        proposalsList.push(proposal);
        balance[msg.sender] -= 0.001 ether;
        emit ProposalAdded(proposal);
    }


    function vote(string memory proposal) external{
        if(balance[msg.sender] < 0.001 ether){
            revert VotingSystem__InsufficientAccountBalance();
        }
        balance[msg.sender] -= 0.001 ether;
        proposals[proposal] += 1;
        emit ProposalVoted(proposal,proposals[proposal]);
    } 

    function addBalance() external payable{
        if(msg.value < 0.001 ether){
            revert VotingSystem__InsufficientBalance();
        }
        
        balance[msg.sender]+= 0.001 ether;
    }

    function getProposalVotes(string memory proposal) external view returns(uint256){
        return proposals[proposal];
    }

    function getUserBalance(address user) external view returns(uint256){
        return balance[user];
    }

    function getProposalsListLength() external view returns(uint256){
        return proposalsList.length;
    }

    function getProposals() external view returns(string[] memory){
        return proposalsList;
    }
}