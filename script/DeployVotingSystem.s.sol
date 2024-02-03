//SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import {VotingSystem} from "../src/VotingSystem.sol";
import {Script} from "forge-std/Script.sol";

contract DeployVotingSystem is Script {
    string[] arr ;
    
    function run() external returns(VotingSystem){
        arr.push("proposal1");
        arr.push("proposal2");
        arr.push("proposal3");
        vm.startBroadcast();
        VotingSystem votingSystem = new VotingSystem(arr);
        vm.stopBroadcast();
        return votingSystem;
    }
}