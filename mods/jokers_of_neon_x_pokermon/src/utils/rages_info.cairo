#[dojo::contract]
pub mod rages_info {
    use dojo::world::Resource::Contract;
    use jokers_of_neon_lib::interfaces::info::rages_info::{IRagesInfo, IRagesInfoDispatcher, IRagesInfoDispatcherTrait};
    use jokers_of_neon_x_pokermon::rages::rages::{rages_ids_all};

    #[abi(embed_v0)]
    impl RagesInfoImpl of IRagesInfo<ContractState> {
        fn get_rages_ids_all(self: @ContractState) -> Array<u32> {
            rages_ids_all()
        }
    }
}
