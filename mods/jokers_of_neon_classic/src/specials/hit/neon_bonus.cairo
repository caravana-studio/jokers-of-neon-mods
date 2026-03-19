#[dojo::contract]
pub mod special_neon_bonus {
    use jokers_of_neon_classic::poker_hand::get_poker_hand_data;
    use jokers_of_neon_classic::specials::specials::SPECIAL_NEON_BONUS_ID;
    use jokers_of_neon_lib::constants::utils::is_neon_card;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::condition::ICardCondition;
    use jokers_of_neon_lib::interfaces::cards::executable::ICardExecutable;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::data::card::Card;
    use jokers_of_neon_lib::models::tracker::GameContext;

    #[abi(embed_v0)]
    impl NeonBonusCondition of ICardCondition<ContractState> {
        fn condition(self: @ContractState, context: GameContext, raw_data: felt252) -> bool {
            let card: Card = raw_data.into();
            card.id >= 200 && card.id <= 253
        }
    }

    #[abi(embed_v0)]
    impl NeonBonusExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            let card_type = context.card_type;
            match card_type {
                CardType::Hit => { (20, 0, 0) },
                CardType::Play => {
                    let mut neon_cards_count = 0;
                    let mut hit_cards_count = 0;
                    for played_card in context.cards_played {
                        if *played_card.hit {
                            hit_cards_count += 1;
                            if is_neon_card(*played_card.card.id) {
                                neon_cards_count += 1;
                            }
                        }
                    }

                    if neon_cards_count == hit_cards_count && hit_cards_count != 0 {
                        let (poker_hand, level) = context.hand;
                        let (leveled_points, leveled_multi) = get_poker_hand_data(poker_hand, level + 2);
                        let (current_points, current_multi) = get_poker_hand_data(poker_hand, level);
                        (
                            (leveled_points - current_points).try_into().unwrap(),
                            (leveled_multi - current_multi).try_into().unwrap(),
                            0,
                        )
                    } else {
                        (0, 0, 0)
                    }
                },
                _ => { (0, 0, 0) },
            }
        }
    }

    #[abi(embed_v0)]
    impl NeonBonusBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_NEON_BONUS_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Hit, CardType::Play].span()
        }
    }
}
