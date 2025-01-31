use starknet::ContractAddress;

#[derive(Copy, Drop, IntrospectPacked, Serde)]
#[dojo::model]
pub struct GameMod {
    #[key]
    pub id: felt252,
    pub owner: ContractAddress,
    pub total_games: u32,
    pub created_date: u64,
    pub last_update_date: u64,
}

#[derive(Copy, Drop, IntrospectPacked, Serde)]
#[dojo::model]
pub struct GameModMap {
    #[key]
    pub idx: u32,
    pub mod_id: felt252,
}

