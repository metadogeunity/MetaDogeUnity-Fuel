// Transpiled from Solidity using charcoal. Generated code may be incorrect or unoptimal.
contract;

use std::constants::ZERO_B256;
use std::hash::Hash;

struct Player {
    kills: u256,
    last_kill_time: u256,
}

enum KillTrackerEvent {
    KillRecorded: (Identity, u256, u256),
    Stop: (),
    Start: (),
}

impl AbiEncode for KillTrackerEvent {
    fn abi_encode(self, buffer: Buffer) -> Buffer {
        let buffer = match self {
            KillTrackerEvent::KillRecorded((a, b, c)) => {
                let buffer = match a {
                    Identity::Address(x) => x.abi_encode(buffer),
                    Identity::ContractId(x) => x.abi_encode(buffer),
                };
                let buffer = b.abi_encode(buffer);
                let buffer = c.abi_encode(buffer);
                buffer
            },
            KillTrackerEvent::Stop => {
                buffer
            },
            KillTrackerEvent::Start => {
                buffer
            },
        };
        buffer
    }
}

abi KillTracker {
    #[storage(read, write)]
    fn constructor();

    #[storage(read)]
    fn owner() -> Identity;

    #[storage(read)]
    fn stopped() -> bool;

    #[storage(read)]
    fn players(a: Identity) -> Player;

    #[storage(read, write)]
    fn record_kill();

    #[storage(read)]
    fn get_kills(player_address: Identity) -> u256;

    #[storage(read)]
    fn get_last_kill_time(player_address: Identity) -> u256;

    #[storage(read, write)]
    fn stop();

    #[storage(read, write)]
    fn start();

    #[storage(read, write)]
    fn transfer_ownership(new_owner: Identity);
}

storage {
    owner: Identity = Identity::Address(Address::from(ZERO_B256)),
    stopped: bool = false,
    players: StorageMap<Identity, Player> = StorageMap {},
    kill_tracker_constructor_called: bool = false,
}

#[storage(read)]
fn auth() {
    require(msg_sender().unwrap() == storage.owner.read(), "ds-auth");
}

#[storage(read)]
fn stoppable() {
    require(!storage.stopped.read(), "ds-stop-is-stopped");
}

impl KillTracker for Contract {
    #[storage(read, write)]
    fn constructor() {
        require(!storage.kill_tracker_constructor_called.read(), "The KillTracker constructor has already been called");
        storage.owner.write(msg_sender().unwrap());
        storage.kill_tracker_constructor_called.write(true);
    }

    #[storage(read)]
    fn owner() -> Identity {
        storage.owner.read()
    }

    #[storage(read)]
    fn stopped() -> bool {
        storage.stopped.read()
    }

    #[storage(read)]
    fn players(a: Identity) -> Player {
        storage.players.get(a).read()
    }

    #[storage(read, write)]
    fn record_kill() {
        stoppable();
        let mut player = storage.players.get(msg_sender().unwrap()).read();
        player.kills += 1;
        player.last_kill_time = std::block::timestamp().as_u256();
        log(KillTrackerEvent::KillRecorded((msg_sender().unwrap(), player.kills, player.last_kill_time)));
    }

    #[storage(read)]
    fn get_kills(player_address: Identity) -> u256 {
        storage.players.get(player_address).read().kills
    }

    #[storage(read)]
    fn get_last_kill_time(player_address: Identity) -> u256 {
        storage.players.get(player_address).read().last_kill_time
    }

    #[storage(read, write)]
    fn stop() {
        auth();
        storage.stopped.write(true);
        log(KillTrackerEvent::Stop);
    }

    #[storage(read, write)]
    fn start() {
        auth();
        storage.stopped.write(false);
        log(KillTrackerEvent::Start);
    }

    #[storage(read, write)]
    fn transfer_ownership(new_owner: Identity) {
        auth();
        storage.owner.write(new_owner);
    }
}

