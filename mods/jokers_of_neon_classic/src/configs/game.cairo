#[dojo::contract]
pub mod game_config {
    use jokers_of_neon_lib::configs::game::{
        DiscountConfig, GameConfig, RageRoundConfig, RoundRewardConfig, ShopPricesConfig,
    };
    use jokers_of_neon_lib::constants::two_pow::two_pow;
    use jokers_of_neon_lib::interfaces::configs::game::IGameConfig;

    #[abi(embed_v0)]
    impl ClassicGameConfig of IGameConfig<ContractState> {
        fn get_game_config_for_tier(self: @ContractState, tier: u8) -> GameConfig {
            GameConfig {
                plays: 3 + bonus_plays(tier),
                discards: 3 + bonus_discards(tier),
                max_special_slots: bonus_slots(tier),
                power_up_slots: 4,
                max_power_up_slots: 4,
                hand_len: 8,
                start_cash: 2000000,
                start_special_slots: 3,
                start_rerolls: 10000,
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
                200 * round
            } else if round <= 11 {
                1800 + (round - 6) * 800
            } else if round <= 18 {
                9600 + (round - 12) * 3800
            } else if round <= 26 {
                52400 + (round - 19) * 20000
            } else if round <= 35 {
                328400 + (round - 27) * 136000
            } else if round <= 45 {
                2416400 + (round - 36) * 1000000
            } else {
                2416400 + 9 * 1000000 + (round - 45) * 1000000
            }
        }

        fn calculate_price_of_slot(self: @ContractState, count_slots: u32) -> u32 {
            let shop_prices_config = self.get_shop_prices_config();
            shop_prices_config.initial_price_slot * two_pow((count_slots - 1).into()).try_into().unwrap()
        }

        fn calculate_price_of_burn(self: @ContractState, count_burns: u32) -> u32 {
            let shop_prices_config = self.get_shop_prices_config();
            shop_prices_config.initial_price_of_burn + (count_burns * 100)
        }
    }

    // Tier 4: play_4 (+1), Tier 15: play_5 (+1)
    fn bonus_plays(tier: u8) -> u32 {
        if tier >= 15 {
            2
        } else if tier >= 4 {
            1
        } else {
            0
        }
    }

    // Tier 10: discard_4 (+1), Tier 21: discard_5 (+1)
    fn bonus_discards(tier: u8) -> u32 {
        if tier >= 21 {
            2
        } else if tier >= 10 {
            1
        } else {
            0
        }
    }

    // Tiers 3,6,9,13,16,19,23: slots total
    fn bonus_slots(tier: u8) -> u32 {
        if tier >= 23 {
            7
        } else if tier >= 19 {
            7
        } else if tier >= 16 {
            6
        } else if tier >= 13 {
            4
        } else if tier >= 9 {
            4
        } else if tier >= 6 {
            3
        } else if tier >= 3 {
            2
        } else {
            1
        }
    }
}
