#[dojo::contract]
pub mod rage_pharaohs_mandate {
    use jokers_of_neon_classic::poker_hand::initial_poker_hands;
    use jokers_of_neon_classic::rages::rages::RAGE_CARD_PHARAOHS_MANDATE;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::level_up::ILevelUp;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::status::game::player::PlayerLevelPokerHand;
    use jokers_of_neon_lib::models::tracker::GameContext;

    #[abi(embed_v0)]
    impl PharaohsMandateLevelUp of ILevelUp<ContractState> {
        fn level_up(
            ref self: ContractState, context: GameContext, player_level_poker_hands: Span<PlayerLevelPokerHand>,
        ) -> Array<PlayerLevelPokerHand> {
            let (played_poker_hand, _) = context.hand;
            let base_hands = initial_poker_hands();
            let mut result: Array<PlayerLevelPokerHand> = array![];

            for player_level_poker_hand in player_level_poker_hands {
                let mut hand = *player_level_poker_hand;
                if hand.poker_hand == played_poker_hand && hand.level > 1 {
                    for base in base_hands.span() {
                        if *base.poker_hand == played_poker_hand {
                            hand.level = 1;
                            hand.points = *base.points;
                            hand.multi = *base.multi;
                            break;
                        }
                    };
                }
                result.append(hand);
            };
            result
        }
    }

    #[abi(embed_v0)]
    impl PharaohsMandateBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            RAGE_CARD_PHARAOHS_MANDATE
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::LevelUpPlay].span()
        }
    }
}
