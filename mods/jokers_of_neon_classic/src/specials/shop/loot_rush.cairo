#[dojo::contract]
pub mod special_loot_rush {
    use jokers_of_neon_classic::specials::specials::SPECIAL_LOOT_RUSH_ID;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::shop_modifier::IShopModifier;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::status::shop::shop::ShopConfig;
    use jokers_of_neon_lib::models::tracker::GameContext;

    #[abi(embed_v0)]
    impl LootRushShopModifier of IShopModifier<ContractState> {
        fn modify_shop_config(ref self: ContractState, context: GameContext, shop_config: ShopConfig) -> ShopConfig {
            let mut config = shop_config;
            config.loot_boxes_quantity += 1;
            config
        }
    }

    #[abi(embed_v0)]
    impl LootRushBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_LOOT_RUSH_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Shop].span()
        }
    }
}
