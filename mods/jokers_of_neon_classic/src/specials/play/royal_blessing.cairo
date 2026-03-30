#[dojo::contract]
pub mod special_royal_blessing {
    use dojo::model::ModelStorage;
    use jokers_of_neon_classic::constants::DEFAULT_NS;
    use jokers_of_neon_classic::poker_hand::get_poker_hand_data;
    use jokers_of_neon_classic::specials::specials::SPECIAL_ROYAL_BLESSING_ID;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::level_up::ILevelUp;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::data::poker_hand::PokerHand;
    use jokers_of_neon_lib::models::status::game::player::PlayerLevelPokerHand;
    use jokers_of_neon_lib::models::tracker::GameContext;
    use crate::utils::random;

    #[abi(embed_v0)]
    impl RoyalBlessingLevelUp of ILevelUp<ContractState> {
        fn level_up(
            ref self: ContractState, context: GameContext, player_level_poker_hands: Span<PlayerLevelPokerHand>,
        ) -> Array<PlayerLevelPokerHand> {
            let mut result: Array<PlayerLevelPokerHand> = array![];
            let (played_poker_hand, _) = context.hand;

            if played_poker_hand == PokerHand::RoyalFlush {
                let mut world = self.world(DEFAULT_NS());
                let hand_count: i32 = player_level_poker_hands.len().try_into().unwrap();
                let random_idx: i32 = random::between(ref world, context, (0, hand_count - 1));
                let target_idx: u32 = random_idx.try_into().unwrap();

                let mut idx: u32 = 0;
                for player_level_poker_hand in player_level_poker_hands {
                    let mut hand = *player_level_poker_hand;
                    if idx == target_idx {
                        let (extra_points, extra_multi) = get_poker_hand_data(hand.poker_hand, 1);
                        hand.level += 1;
                        hand.points += extra_points;
                        hand.multi += extra_multi;
                    }
                    result.append(hand);
                    idx += 1;
                };
            } else {
                for player_level_poker_hand in player_level_poker_hands {
                    result.append(*player_level_poker_hand);
                };
            }
            result
        }
    }

    #[abi(embed_v0)]
    impl RoyalBlessingBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_ROYAL_BLESSING_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::LevelUpPlay].span()
        }
    }
}
