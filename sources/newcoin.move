/*
/// Module: newcoin
module newcoin::newcoin;
*/

// For Move coding conventions, see
// https://docs.sui.io/concepts/sui-move-concepts/conventions


// sources/mycoin.move
module newcoin::my_coin {
    use sui::coin::{Self, TreasuryCap, Coin};
    use sui::transfer;
    use sui::tx_context::{TxContext};

    // Witness type for OTW pattern


    public struct MY_COIN has drop {}

    // Initialize currency
    fun init(witness: MY_COIN, ctx: &mut TxContext) {
        let (treasury, metadata) = coin::create_currency(
            witness,
            6, // Decimals
            b"MYC", // Symbol
            b"My Custom Coin", // Name
            b"Demo coin for Challenge 2", // Description
            option::none(), // Icon URL
            ctx
        );
        
        transfer::public_freeze_object(metadata);
        transfer::public_transfer(treasury, tx_context::sender(ctx));
    }

    // Mint new coins
    public entry fun mint(
        treasury: &mut TreasuryCap<MY_COIN>,
        amount: u64,
        recipient: address,
        ctx: &mut TxContext
    ) {
        let new_coins = coin::mint(treasury, amount, ctx);
        transfer::public_transfer(new_coins, recipient);
    }

    // Burn existing coins
    public entry fun burn(
        treasury: &mut TreasuryCap<MY_COIN>,
        coins: Coin<MY_COIN>
    ) {
        coin::burn(treasury, coins);
    }
}
