use starknet::ContractAddress;

#[derive(Copy, Drop, Serde)]
#[dojo::model]
pub struct SpecialData {
    #[key]
    pub mod_id: u32,
    #[key]
    pub special_id: u32,
    pub contract_address: ContractAddress
}
