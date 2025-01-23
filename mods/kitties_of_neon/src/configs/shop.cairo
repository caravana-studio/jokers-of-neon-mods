#[dojo::contract]
pub mod shop_config {
    use jokers_of_neon_lib::{configs::shop::ShopConfig, interfaces::configs::shop::IShopConfig};

    #[abi(embed_v0)]
    impl ClassicShopConfig of IShopConfig<ContractState> {
        fn get_shop_config(self: @ContractState) -> ShopConfig {
            ShopConfig {
                traditional_cards_quantity: 1,
                modifiers_cards_quantity: 0,
                specials_cards_quantity: 3,
                loot_boxes_quantity: 2,
                power_ups_quantity: 0,
                poker_hands_quantity: 4
            }
        }
    }
}
