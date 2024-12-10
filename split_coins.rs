use fuels::prelude::*;
use fuels::prelude::TxParameters;

#[tokio::main]
async fn main() -> fuels::types::errors::Result<()> {
    // Connect to the Fuel mainnet node
    let provider = Provider::connect("https://mainnet.fuel.network").await?;
    println!("Connected to Fuel mainnet!");

    // Load the wallet
    let wallet = WalletUnlocked::load_keystore(
        "/Users/ashu2793/.fuel/wallets/.wallet", // Path to your wallet
        "Krishna@123",                          // Password for your wallet
        Some(provider.clone()),
    )?;
    println!("Wallet successfully loaded!");

    // Check the total balance
    let coins = provider.get_coins(wallet.address(), AssetId::default()).await?;
    let total_balance: u64 = coins.iter().map(|coin| coin.amount).sum();
    println!("Total wallet balance: {}", total_balance);

    // Define parameters for splitting
    let to_address = wallet.address(); // Send to self for splitting
    let asset_id = AssetId::from([
        0xf8, 0xf8, 0xb6, 0x28, 0x3d, 0x7f, 0xa5, 0xb6,
        0x72, 0xb5, 0x30, 0xcb, 0xb8, 0x4f, 0xcc, 0xcb,
        0x4f, 0xf8, 0xdc, 0x40, 0xf8, 0x17, 0x6e, 0xf4,
        0x54, 0x4d, 0xdb, 0x1f, 0x19, 0x52, 0xad, 0x07,
    ]);
    let amount = 1_000_000; // Amount per split

    if total_balance < amount {
        println!("Insufficient balance for splitting. Total balance: {}", total_balance);
        return Ok(());
    }

    let num_splits = total_balance / amount;

    println!(
        "Splitting {} coins into {} parts of {} each.",
        amount * num_splits,
        num_splits,
        amount
    );

    // Perform the splits
    for i in 0..num_splits {
        let result = wallet
            .transfer(&to_address, amount, asset_id, TxParameters::default())
            .await;

        match result {
            Ok(tx_id) => println!("Split {} successful! Transaction ID: {:?}", i + 1, tx_id),
            Err(e) => {
                println!("Split {} failed: {:?}", i + 1, e);
                break;
            }
        }
    }

    println!("Splitting completed!");
    Ok(())
}