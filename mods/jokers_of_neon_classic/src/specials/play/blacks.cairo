#[dojo::contract]
pub mod special_blacks {
    use jokers_of_neon_classic::specials::specials::SPECIAL_BLACKS_ID;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::executable::ICardExecutable;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::data::card::Suit;
    use jokers_of_neon_lib::models::tracker::GameContext;

    #[abi(embed_v0)]
    impl BlacksExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            let mut count: u8 = 0;
            let mut count_spades: u8 = 0;
            let mut count_clubs: u8 = 0;
            for played_card in context.cards_played {
                if *played_card.hit && !*played_card.silenced {
                    if *played_card.card.suit == Suit::Spades {
                        count_spades = count_spades + 1;
                    } else if *played_card.card.suit == Suit::Clubs {
                        count_clubs = count_clubs + 1;
                    }
                    count = count + 1;
                }
            }

            if count == count_spades + count_clubs && count_spades > 0 && count_clubs > 0 {
                (0, 10, 0)
            } else {
                (0, 0, 0)
            }
        }
    }

    #[abi(embed_v0)]
    impl BlacksBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_BLACKS_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Play].span()
        }
    }
}
