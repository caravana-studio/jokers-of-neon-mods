#[dojo::contract]
pub mod special_midas_hand {
    use jokers_of_neon_classic::specials::specials::SPECIAL_MIDAS_HAND_ID;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::executable::ICardExecutable;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::data::card::Suit;
    use jokers_of_neon_lib::models::tracker::GameContext;

    #[abi(embed_v0)]
    impl MidasHandExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            let mut count_hit: u32 = 0;
            let mut count_diamonds: u32 = 0;
            for played_card in context.cards_played {
                if *played_card.hit {
                    count_hit += 1;
                    if *played_card.card.suit == Suit::Diamonds {
                        count_diamonds += 1;
                    }
                }
            }
            if count_hit > 0 && count_diamonds * 2 >= count_hit {
                (0, 0, 250)
            } else {
                (0, 0, 0)
            }
        }
    }

    #[abi(embed_v0)]
    impl MidasHandBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_MIDAS_HAND_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Play].span()
        }
    }
}
