#[dojo::contract]
pub mod special_double_down {
    use jokers_of_neon_classic::poker_hand::{initial_poker_hands, poker_hands_info};
    use jokers_of_neon_classic::specials::specials::SPECIAL_DOUBLE_DOWN_ID;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::executable::ICardExecutable;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::tracker::GameContext;

    #[abi(embed_v0)]
    impl DoubleDownExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            let (poker_hand, level) = context.hand;

            // Get initial base points (level 1)
            let hands = initial_poker_hands();
            let mut base_points: u32 = 0;
            for hand in hands {
                if hand.poker_hand == poker_hand {
                    base_points = hand.points;
                    break;
                }
            }

            // Get level-up points per level for this hand's category
            let (all_hands, _, _, points_per_level, _) = poker_hands_info();
            let mut level_up_points: u32 = 0;
            let mut category_idx: u32 = 0;
            for category in all_hands {
                for hand in *category {
                    if *hand == poker_hand {
                        level_up_points = *points_per_level.at(category_idx);
                        break;
                    }
                }
                category_idx += 1;
            }

            // Total points at current level = base + level_up * (level - 1)
            let total_points = base_points + level_up_points * (level - 1);
            let bonus: i32 = total_points.try_into().unwrap();
            (bonus, 0, 0)
        }
    }

    #[abi(embed_v0)]
    impl DoubleDownBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_DOUBLE_DOWN_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Play].span()
        }
    }
}
