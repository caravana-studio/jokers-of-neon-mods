#[dojo::contract]
pub mod shop_config {
    use jokers_of_neon_lib::{configs::shop::ShopConfig, interfaces::configs::shop::IShopConfig};

    #[abi(embed_v0)]
    impl ClassicShopConfig of IShopConfig<ContractState> {
        fn get_shop_config(self: @ContractState) -> ShopConfig {
            ShopConfig {
                traditional_cards_quantity: 4,
                modifiers_cards_quantity: 2,
                specials_cards_quantity: 4,
                loot_boxes_quantity: 2,
                power_ups_quantity: 2,
                poker_hands_quantity: 2
            }
        }
    }
}
