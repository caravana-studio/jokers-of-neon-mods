use jokers_of_neon_mods::models::mod_config::ModConfig;
use starknet::ContractAddress;

#[derive(Copy, Drop, IntrospectPacked, Serde)]
#[dojo::model]
pub struct GameMod {
    #[key]
    pub id: u32,
    pub name: felt252,
    pub owner: ContractAddress,
    pub config: ModConfig,
    pub total_games: u32,
    pub created_date: u64,
    pub last_update_date: u64,
}
