#[dojo::contract]
pub mod registrator_system {
    use dojo::world::Resource::Contract;
    use jokers_of_neon_lib::interfaces::registrator::{
        IRegistrator, IRegistratorDispatcher, IRegistratorDispatcherTrait
    };
    use starknet::{ContractAddress, contract_address_const};

    pub fn JOKERS_OF_NEON_CORE_REGISTRATOR_ADDRESS() -> ContractAddress {
        contract_address_const::<0x04722b045d9e446fc7e6f9b7769900a8b2f0117a67442e347a4da6e17b6ed59b>()
    }

    #[abi(embed_v0)]
    impl RegistratorBaseImpl of IRegistrator<ContractState> {
        fn register_game_mod(ref self: ContractState, mod_name: felt252) -> u32 {
            IRegistratorDispatcher { contract_address: JOKERS_OF_NEON_CORE_REGISTRATOR_ADDRESS() }
                .register_game_mod(mod_name)
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
    }
}
