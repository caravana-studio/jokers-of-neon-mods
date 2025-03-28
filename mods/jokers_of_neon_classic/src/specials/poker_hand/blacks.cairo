#[dojo::contract]
pub mod special_blacks {
    use jokers_of_neon_classic::specials::specials::SPECIAL_BLACKS_ID;
    use jokers_of_neon_lib::interfaces::{base::ICardBase, cards::executable::ICardExecutable};
    use jokers_of_neon_lib::models::{
        card_type::CardType, data::card::{Card, Suit}, data::poker_hand::PokerHand, tracker::GameContext,
    };

    #[abi(embed_v0)]
    impl BlacksExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            let mut count: u8 = 0;
            let mut count_spades: u8 = 0;
            let mut count_clubs: u8 = 0;
            let mut cards = context.cards_played;
            loop {
                match cards.pop_front() {
                    Option::Some((
                        hit, _, card,
                    )) => {
                        if *hit {
                            if *card.suit == Suit::Spades {
                                count_spades = count_spades + 1;
                            } else if *card.suit == Suit::Clubs {
                                count_clubs = count_clubs + 1;
                            }
                            count = count + 1;
                        }
                    },
                    Option::None => { break; },
                }
            };

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
            array![CardType::PokerHand].span()
        }
    }
}
