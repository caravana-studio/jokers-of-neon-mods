#[dojo::contract]
pub mod specials_info {
    use dojo::world::Resource::Contract;
    use jokers_of_neon_classic::specials::specials::{specials_ids_all, specials_shop_info};
    use jokers_of_neon_lib::interfaces::info::specials_info::{
        ISpecialsInfo, ISpecialsInfoDispatcher, ISpecialsInfoDispatcherTrait
    };

    #[abi(embed_v0)]
    impl SpecialsInfoImpl of ISpecialsInfo<ContractState> {
        fn get_specials_ids_all(self: @ContractState) -> Array<u32> {
            specials_ids_all()
        }

        fn get_specials_shop_info(self: @ContractState) -> (Span<Span<u32>>, Span<u32>, Span<u32>) {
            specials_shop_info()
        }
    }
}
