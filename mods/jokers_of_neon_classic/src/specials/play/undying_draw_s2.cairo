#[dojo::contract]
pub mod special_undying_draw_s2 {
    use jokers_of_neon_classic::poker_hand::get_poker_hand_data;
    use jokers_of_neon_classic::specials::specials::SPECIAL_UNDYING_DRAW_S2_ID;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::level_up::ILevelUp;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::status::game::player::PlayerLevelPokerHand;
    use jokers_of_neon_lib::models::tracker::GameContext;

    #[abi(embed_v0)]
    impl UndyingDrawS2LevelUp of ILevelUp<ContractState> {
        fn level_up(
            ref self: ContractState, context: GameContext, player_level_poker_hands: Span<PlayerLevelPokerHand>,
        ) -> Array<PlayerLevelPokerHand> {
            let mut result: Array<PlayerLevelPokerHand> = array![];

            let first_discard_used = context.round.remaining_discards.into() == context.game.discards;

            if first_discard_used {
                let (played_poker_hand, _) = context.hand;

                for player_level_poker_hand in player_level_poker_hands {
                    let mut hand = *player_level_poker_hand;
                    if hand.poker_hand == played_poker_hand {
                        hand.level += 1;
                        let (extra_points, extra_multi) = get_poker_hand_data(hand.poker_hand, 1);
                        hand.points += extra_points;
                        hand.multi += extra_multi;
                    }
                    result.append(hand);
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
    impl UndyingDrawS2Base of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_UNDYING_DRAW_S2_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::LevelUpPlay].span()
        }
    }
}
