#[dojo::contract]
pub mod special_suit_circuit {
    use jokers_of_neon_classic::specials::specials::SPECIAL_SUIT_CIRCUIT_ID;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::executable::ICardExecutable;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::data::card::Suit;
    use jokers_of_neon_lib::models::tracker::GameContext;

    #[abi(embed_v0)]
    impl SuitCircuitExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            let mut count_suits: u32 = 0;
            let mut count_spades: u8 = 0;
            let mut count_clubs: u8 = 0;
            let mut count_hearts: u8 = 0;
            let mut count_diamonds: u8 = 0;

            for played_card in context.cards_played {
                if *played_card.hit {
                    if *played_card.card.suit == Suit::Spades {
                        count_spades += 1;
                    } else if *played_card.card.suit == Suit::Clubs {
                        count_clubs += 1;
                    } else if *played_card.card.suit == Suit::Hearts {
                        count_hearts += 1;
                    } else if *played_card.card.suit == Suit::Diamonds {
                        count_diamonds += 1;
                    }
                }
            }

            if count_spades > 0 {
                count_suits += 1;
            }
            if count_clubs > 0 {
                count_suits += 1;
            }
            if count_hearts > 0 {
                count_suits += 1;
            }
            if count_diamonds > 0 {
                count_suits += 1;
            }

            ((count_suits * 40).try_into().unwrap(), 0, 0)
        }
    }

    #[abi(embed_v0)]
    impl SuitCircuitBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_SUIT_CIRCUIT_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Play].span()
        }
    }
}
