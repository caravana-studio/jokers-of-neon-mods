#[dojo::contract]
pub mod game_config {
    use jokers_of_neon_lib::configs::game::{
        DiscountConfig, GameConfig, RageRoundConfig, RoundRewardConfig, ShopPricesConfig,
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
                start_cash: 0,
                start_special_slots: 1,
                start_rerolls: 1,
            }
        }

        fn get_shop_prices_config(self: @ContractState) -> ShopPricesConfig {
            ShopPricesConfig {
                initial_price_slot: 600,
                initial_price_of_burn: 100,
                price_of_traditional_cards: 200,
                price_of_neon_traditional_cards: 700,
                price_of_joker_card: 1500,
                price_of_neon_joker_card: 3000,
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

        fn calculate_round_score(self: @ContractState, round: u32) -> u32 {
            if round <= 5 {
                300 * round
            } else if round <= 11 {
                2400 + (round - 6) * 900
            } else if round <= 18 {
                10500 + (round - 12) * 3600
            } else if round <= 26 {
                50100 + (round - 19) * 18000
            } else if round <= 35 {
                284100 + (round - 27) * 108000
            }  else if round <= 45 { 
                1904100 + (round - 36) * 756000
            }  else if round <= 56 {
                14756100 + (round - 46) * 6048000 
            } else {
                178052100 + (round - 57) * 54432000 
            }
        }

        fn calculate_price_of_slot(self: @ContractState, count_slots: u32) -> u32 {
            let shop_prices_config = self.get_shop_prices_config();
            shop_prices_config.initial_price_slot * two_pow((count_slots - 1).into()).try_into().unwrap()
        }

        fn calculate_price_of_burn(self: @ContractState, count_burns: u32) -> u32 {
            let shop_prices_config = self.get_shop_prices_config();
            shop_prices_config.initial_price_of_burn + (count_burns * 200)
        }
    }
}
