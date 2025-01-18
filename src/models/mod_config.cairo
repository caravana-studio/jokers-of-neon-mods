use starknet::ContractAddress;

#[derive(Copy, Drop, IntrospectPacked, Serde)]
#[dojo::model]
pub struct ModConfig {
    #[key]
    pub mod_id: felt252,
    pub deck_address: ContractAddress,
    pub specials_address: ContractAddress,
    pub rages_address: ContractAddress,
    pub loot_boxes_address: ContractAddress,
    pub game_config_address: ContractAddress,
    pub shop_config_address: ContractAddress
}
