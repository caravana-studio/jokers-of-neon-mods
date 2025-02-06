use starknet::ContractAddress;

#[derive(Copy, Drop, Serde)]
#[dojo::model]
pub struct RageData {
    #[key]
    pub mod_id: felt252,
    #[key]
    pub rage_id: u32,
    pub contract_address: ContractAddress,
}
