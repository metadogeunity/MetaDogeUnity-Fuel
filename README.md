MetaDogeUnity Fuel - Smart Contract for Gaming on Fuel Network

MetaDogeUnity is an innovative gaming project utilizing smart contract technology on the Fuel blockchain. This repository includes the deployment scripts, interaction code, and game logic for the MetaDogeUnity Fuel project.

🚀 Project Overview

MetaDogeUnity aims to redefine blockchain gaming by leveraging the speed and scalability of the Fuel network. It includes:
	•	A robust smart contract to handle player actions like kills and rewards.
	•	Integration with the Fuel mainnet for decentralized operations.
	•	Coin management using split and transaction scripts.

This contract supports a kill-tracking mechanism where player data is stored and updated based on in-game actions. Players can earn in-game rewards for their performance, and the data is secured on the Fuel blockchain.

📜 Features
	1.	Kill Tracking:
	•	Tracks the number of kills for each player.
	•	Records the last kill timestamp.
	2.	Reward Mechanism:
	•	Distributes in-game assets based on player performance.
	•	Rewards are stored as UTXOs (Unspent Transaction Outputs) for efficient management.
	3.	Player Management:
	•	Manages player data securely on the blockchain.
	•	Provides transparency and immutability for all transactions.
	4.	Fuel Blockchain Integration:
	•	Deployed on the Fuel mainnet for scalability and low fees.
	•	Fully compatible with Fuel wallet and UTXO models.

🕹️ Game Logic

Kill Tracker

	1.	Record kills for a player:
fn record_kill(player: Address);

	2.	Retrieve a player’s kill count:
fn get_kills(player: Address) -> u64;

	3.	Retrieve the last kill timestamp:
fn get_last_kill_time(player: Address) -> u64;

In-Game Rewards

Players earn rewards based on their kill count. The rewards are distributed in the form of Fuel network UTXOs.

📄 Scripts

Split Coins

Splits a wallet’s balance into smaller UTXOs for efficient game operations.

🌐 Resources

	1.	Fuel Documentation:
	•	Fuel Network
	•	GraphQL API
	2.	Explorer:
	•	Fuel Explorer

📜 License

This project is licensed under the MIT License.

🧑‍💻 Contributors
	•	Uday Kiran :  Smart Contract Developer
	•	MetaDogeUnity Team: Game Design and Blockchain Integration


