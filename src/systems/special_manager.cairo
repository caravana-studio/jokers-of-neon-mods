use starknet::ContractAddress;

#[starknet::interface]
trait ISpecialManager<T> {
    fn register_special(ref self: T, mod_id: u32, special_id: u32, contract_address: ContractAddress);
    fn register_specials(ref self: T, mod_id: u32, special_ids: Span<u32>, contract_addresses: Span<ContractAddress>);
}

#[dojo::contract]
pub mod special_manager {
    use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};
    use jokers_of_neon_mods::{models::{game_mod::GameMod, special_data::SpecialData}, store::{StoreTrait, StoreImpl}};
    use starknet::{ContractAddress, get_caller_address};

    #[abi(embed_v0)]
    impl SpecialManagerImpl of super::ISpecialManager<ContractState> {
        fn register_special(ref self: ContractState, mod_id: u32, special_id: u32, contract_address: ContractAddress) {
            let mut world = self.world(@"jokers_of_neon");
            let mut store = StoreTrait::new(ref world);
            let game_mod = store.get_game_mod(mod_id);

            assert(game_mod.owner == get_caller_address(), 'Caller is not owner of the mod');
            let special_data = store.get_special_data(mod_id, special_id);

            assert(special_data.contract_address.is_zero(), 'Special card already registered');
            store.set_special_data(SpecialData { mod_id, special_id, contract_address });
        }

        fn register_specials(
            ref self: ContractState, mod_id: u32, special_ids: Span<u32>, contract_addresses: Span<ContractAddress>
        ) {
            assert(special_ids.len() == contract_addresses.len(), 'Invalid length of special cards');
            let mut special_ids = special_ids;
            let mut contract_addresses = contract_addresses;
            loop {
                match special_ids.pop_front() {
                    Option::Some(special_id) => {
                        self.register_special(mod_id, *special_id, *(contract_addresses.pop_front()).unwrap());
                    },
                    Option::None => { break; }
                };
            }
        }
    }
}
