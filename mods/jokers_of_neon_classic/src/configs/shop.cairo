#[dojo::contract]
pub mod shop_config {
    use jokers_of_neon_lib::configs::game::ShopPricesConfig;
    use jokers_of_neon_lib::models::status::shop::shop::ShopConfig;
    use jokers_of_neon_lib::interfaces::configs::shop::IShopConfig;
    use jokers_of_neon_classic::shop_config::{shop_configs_ids_all, shop_configs_info, get_shop_config};

    #[abi(embed_v0)]
    impl ClassicShopConfig of IShopConfig<ContractState> {

        fn get_shop_configs_ids_all(self: @ContractState) -> Array<u32> {
            shop_configs_ids_all()
        }

        fn get_shop_configs_info(self: @ContractState) -> (Span<Span<u32>>, Span<u32>) {
            shop_configs_info()
        }

        fn get_shop_config(self: @ContractState, shop_config_id: u32) -> ShopConfig {
            get_shop_config(shop_config_id)
        }
    }
}
