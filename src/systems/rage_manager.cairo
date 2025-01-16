use starknet::ContractAddress;

#[starknet::interface]
trait IRageManager<T> {
    fn register_rage(ref self: T, mod_id: u32, rage_id: u32, contract_address: ContractAddress);
    fn register_rages(ref self: T, mod_id: u32, rage_ids: Span<u32>, contract_addresses: Span<ContractAddress>);
    fn get_rage_address(self: @T, mod_id: u32, rage_id: u32) -> ContractAddress;
}

#[dojo::contract]
pub mod rage_manager {
    use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};
    use jokers_of_neon_mods::{models::{game_mod::GameMod, rage_data::RageData}, store::{StoreTrait, StoreImpl}};
    use starknet::{ContractAddress, get_caller_address};

    #[abi(embed_v0)]
    impl RageManagerImpl of super::IRageManager<ContractState> {
        fn register_rage(ref self: ContractState, mod_id: u32, rage_id: u32, contract_address: ContractAddress) {
            let mut world = self.world(@"jokers_of_neon_mods");
            let mut store = StoreTrait::new(ref world);
            let game_mod = store.get_game_mod(mod_id);

            assert(game_mod.owner == get_caller_address(), 'Caller is not owner of the mod');
            let rage_data = store.get_rage_data(mod_id, rage_id);

            assert(rage_data.contract_address.is_zero(), 'Special card already registered');
            store.set_rage_data(RageData { mod_id, rage_id, contract_address });
        }

        fn register_rages(
            ref self: ContractState, mod_id: u32, rage_ids: Span<u32>, contract_addresses: Span<ContractAddress>
        ) {
            assert(rage_ids.len() == contract_addresses.len(), 'Invalid length of special cards');
            let mut rage_ids = rage_ids;
            let mut contract_addresses = contract_addresses;
            loop {
                match rage_ids.pop_front() {
                    Option::Some(rage_id) => {
                        self.register_rage(mod_id, *rage_id, *(contract_addresses.pop_front()).unwrap());
                    },
                    Option::None => { break; }
                };
            }
        }

        fn get_rage_address(self: @ContractState, mod_id: u32, rage_id: u32) -> ContractAddress {
            let mut world = self.world(@"jokers_of_neon_mods");
            let mut store = StoreTrait::new(ref world);
            let special_data = store.get_rage_data(mod_id, rage_id);

            assert(!special_data.contract_address.is_zero(), 'Special card not registered');
            special_data.contract_address
        }
    }
}
