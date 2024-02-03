//SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import {VotingSystem} from "../src/VotingSystem.sol";
import {DeployVotingSystem} from "../script/DeployVotingSystem.s.sol";
import {Test} from "forge-std/Test.sol";

contract VotingSystemTest is Test {
    VotingSystem public votingSystem;
    DeployVotingSystem public deployVotingSystem;
    address USER = makeAddr("User");
    string[] public allProposals;

    function setUp() public {
        deployVotingSystem = new DeployVotingSystem();
        votingSystem = deployVotingSystem.run();
        vm.deal(USER,0.01 ether);
    }

    function testCanFund() public {
        vm.prank(USER);
        votingSystem.addBalance{value:0.001 ether}();
        assertEq(votingSystem.getUserBalance(USER),0.001 ether);
    }

    function testCanVoteAndBalanceDecreases() public Funded{
        vm.prank(USER);
        votingSystem.vote("proposal1");
        assertEq(votingSystem.getUserBalance(USER),0);
        assertEq(votingSystem.getProposalVotes("proposal1"),1);
    }

    function testCanAddProposal() public Funded{
        vm.prank(USER);
        votingSystem.addProposal("proposal4");
        allProposals = votingSystem.getProposals();
        bool flag;
        for(uint i=0;i<allProposals.length;i++){
            if(keccak256(bytes(allProposals[i]))==keccak256(bytes("proposal4"))){
                flag=true;
                break;
            }
        }
        assertEq(flag,true);
    }

    modifier Funded() {
        vm.prank(USER);
        votingSystem.addBalance{value:0.001 ether}();
        _;
    }
}