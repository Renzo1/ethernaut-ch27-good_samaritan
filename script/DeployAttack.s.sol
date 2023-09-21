// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {Script} from "lib/forge-std/src/Script.sol";
import {Attack} from "../src/Attack.sol";

contract DeployAttack is Script {
    address goodSamaritanAddr;

    function run() external returns (Attack) {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        goodSamaritanAddr = 0x7a68A96ecb29dc495489fA29232331001885D892;

        vm.startBroadcast(deployerPrivateKey);
        Attack attack = new Attack(goodSamaritanAddr);
        vm.stopBroadcast();

        return (attack);
    }
}

// forge script script/DeployAttack.s.sol:DeployAttack --rpc-url $SEPOLIA_RPC_URL --broadcast --verify -vvv
