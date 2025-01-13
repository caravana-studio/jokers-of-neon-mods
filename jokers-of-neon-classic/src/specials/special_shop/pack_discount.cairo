#[dojo::contract]
pub mod special_pack_discount {
    use jokers_of_neon_classic::specials::specials::SPECIAL_PACK_DISCOUNT_ID;
    use jokers_of_neon_lib::interfaces::shop::ISpecialShopType;
    use jokers_of_neon_lib::models::discount_section::DiscountSection;
    use jokers_of_neon_lib::models::special_type::SpecialType;

    #[abi(embed_v0)]
    impl SpecialPackDiscountImpl of ISpecialShopType<ContractState> {
        fn apply(ref self: ContractState) -> Array<(DiscountSection, u32)> {
            array![(DiscountSection::LootBoxes, 30)]
        }

        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_PACK_DISCOUNT_ID
        }

        fn get_type(self: @ContractState) -> SpecialType {
            SpecialType::Shop
        }
    }
}
