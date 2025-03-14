#[dojo::contract]
pub mod game_config {
    use jokers_of_neon_lib::configs::game::{
        DiscountConfig, GameConfig, RageRoundConfig, RoundRewardConfig, ShopConfig, ShopPricesConfig,
    };
    use jokers_of_neon_lib::constants::two_pow::two_pow;
    use jokers_of_neon_lib::interfaces::configs::game::IGameConfig;

    #[abi(embed_v0)]
    impl ClassicGameConfig of IGameConfig<ContractState> {
        fn get_game_config(self: @ContractState) -> GameConfig {
            GameConfig {
                plays: 5,
                discards: 5,
                max_special_slots: 7,
                power_up_slots: 4,
                max_power_up_slots: 4,
                hand_len: 8,
                start_cash: 1000,
                start_special_slots: 1,
            }
        }

        fn get_shop_config(self: @ContractState) -> ShopConfig {
            ShopConfig {
                traditional_cards_quantity: 5,
                modifiers_cards_quantity: 3,
                specials_cards_quantity: 3,
                loot_boxes_quantity: 2,
                power_ups_quantity: 2,
                poker_hands_quantity: 3,
            }
        }

        fn get_shop_prices_config(self: @ContractState) -> ShopPricesConfig {
            ShopPricesConfig {
                initial_price_slot: 100,
                initial_price_of_burn: 400,
                initial_price_of_reroll: 100,
                number_of_burns_per_store: 100,
                number_of_rerolls_per_store: 100,
                price_of_traditional_cards: 100,
                price_of_modifier_cards: 100,
            }
        }

        fn get_round_reward_config(self: @ContractState) -> RoundRewardConfig {
            RoundRewardConfig { reward: 500, reward_per_discards: 150, reward_per_plays: 150 }
        }

        fn get_rage_round_config(self: @ContractState) -> RageRoundConfig {
            RageRoundConfig {
                initial_probability: 35,
                increment_by_round: 15,
                rages_quantity_for_x_round: 6,
                max_active_rages: 4,
                min_round_level_before_activate: 3,
                level_cooldown: 1,
            }
        }

        fn get_discount_config(self: @ContractState) -> DiscountConfig {
            DiscountConfig { max_discounts_per_shop: 3, tries: 10 }
        }

        fn calculate_level_score(self: @ContractState, level: u32) -> u32 {
            if level <= 2 {
                300 * level
            } else if level <= 10 {
                600 * level - 600
            } else if level <= 20 {
                1200 * level - 6600
            } else if level <= 25 {
                3000 * level - 42600
            } else if level <= 30 {
                7000 * level - 142600
            } else {
                20000 * level - 532600
            }
        }

        fn calculate_price_of_slot(self: @ContractState, count_slots: u32) -> u32 {
            let shop_prices_config = self.get_shop_prices_config();
            shop_prices_config.initial_price_slot * two_pow((count_slots).into()).try_into().unwrap()
        }

        fn calculate_price_of_burn(self: @ContractState, count_burns: u32) -> u32 {
            let shop_prices_config = self.get_shop_prices_config();
            shop_prices_config.initial_price_of_burn + (count_burns * 200)
        }

        fn calculate_price_of_reroll(self: @ContractState, count_rerolls: u32) -> u32 {
            let shop_prices_config = self.get_shop_prices_config();
            shop_prices_config.initial_price_of_reroll * (count_rerolls + 1)
        }
    }
}
