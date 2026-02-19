#[dojo::contract]
pub mod specials_info {
    use jokers_of_neon_classic::specials::specials::{
        get_base_specials_shop_info, get_season_specials_shop_info, get_special_info, specials_ids_all,
    };
    use jokers_of_neon_lib::interfaces::info::specials_info::ISpecialsInfo;

    #[abi(embed_v0)]
    impl SpecialsInfoImpl of ISpecialsInfo<ContractState> {
        fn get_specials_ids_all(self: @ContractState) -> Array<u32> {
            specials_ids_all()
        }

        fn get_base_specials_shop_info(self: @ContractState) -> (Span<Span<u32>>, Span<u32>, Span<u32>) {
            get_base_specials_shop_info()
        }

        fn get_season_specials_shop_info(self: @ContractState) -> (Span<Span<u32>>, Span<u32>, Span<u32>) {
            get_season_specials_shop_info()
        }

        // returns (category, price, probability)
        fn get_special_info(self: @ContractState, special_id: u32) -> (u32, u32, u32) {
            get_special_info(special_id)
        }
    }
}
