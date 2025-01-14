#[dojo::contract]
pub mod configurator_system {
    use jokers::models::config::game_config::GameConfig;
    use jokers::models::config::round_rewards_config::RoundConfig;
    use jokers::models::config::shop_config::ShopConfig;
    use jokers_of_neon_lib::interfaces::configurator::{
        IConfigurator, IConfiguratorDispatcher, IConfiguratorDispatcherTrait
    };

    #[abi(embed_v0)]
    impl ConfiguratorBaseImpl of IConfigurator<ContractState> {
        fn get_game_config(ref self: ContractState) -> GameConfig {
            GameConfig { max_plays: 5, max_discard: 5, len_hand: 8, len_max_special_cards: 7, len_max_power_ups: 4 }
        }

        fn get_shop_config(ref self: ContractState) -> ShopConfig {
            ShopConfig {
                initial_reroll_cost: 100,
                len_item_common_cards: 5,
                len_item_modifier_cards: 3,
                len_item_special_cards: 3,
                len_item_poker_hands: 3,
                len_item_blister_pack: 2,
                len_item_power_ups: 2
            }
        }

        fn get_round_config(ref self: ContractState) -> RoundConfig {
            RoundConfig { reward: 100, reward_per_discards: 100, reward_per_plays: 100 }
        }
    }
}

