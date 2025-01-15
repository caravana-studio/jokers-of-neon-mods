#[dojo::contract]
pub mod registrator_system {
    use dojo::world::Resource::Contract;
    use jokers_of_neon_lib::interfaces::registrator::{
        IRegistrator, IRegistratorDispatcher, IRegistratorDispatcherTrait
    };
    use starknet::{ContractAddress, contract_address_const};

    pub fn JOKERS_OF_NEON_CORE_REGISTRATOR_ADDRESS() -> ContractAddress {
        contract_address_const::<0x0025279a15663ed9bd2aee520f046a6f1f068a882f55ec22de0f15582a25f744>()
    }

    #[abi(embed_v0)]
    impl RegistratorBaseImpl of IRegistrator<ContractState> {
        fn register_game_mod(ref self: ContractState, mod_name: felt252, loot_boxes_info_system_address: ContractAddress, specials_info_system_address: ContractAddress) -> u32 {
            IRegistratorDispatcher { contract_address: JOKERS_OF_NEON_CORE_REGISTRATOR_ADDRESS() }
                .register_game_mod(mod_name, loot_boxes_info_system_address, specials_info_system_address)
        }

        fn register_special(ref self: ContractState, mod_id: u32, special_id: u32, contract_address: ContractAddress) {
            IRegistratorDispatcher { contract_address: JOKERS_OF_NEON_CORE_REGISTRATOR_ADDRESS() }
                .register_special(mod_id, special_id, contract_address);
        }

        fn register_specials(
            ref self: ContractState, mod_id: u32, special_ids: Span<u32>, contract_addresses: Span<ContractAddress>
        ) {
            IRegistratorDispatcher { contract_address: JOKERS_OF_NEON_CORE_REGISTRATOR_ADDRESS() }
                .register_specials(mod_id, special_ids, contract_addresses);
        }

        fn register_rage(ref self: ContractState, mod_id: u32, rage_id: u32, contract_address: ContractAddress) {
            
        }

        fn register_rages(
            ref self: ContractState, mod_id: u32, rage_ids: Span<u32>, contract_addresses: Span<ContractAddress>
        ) {
            
        }
    }
}
