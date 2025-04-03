#[dojo::contract]
pub mod special_rainbow {
    use jokers_of_neon_classic::specials::specials::SPECIAL_RAINBOW_ID;
    use jokers_of_neon_lib::interfaces::{base::ICardBase, cards::executable::ICardExecutable};
    use jokers_of_neon_lib::models::{
        card_type::CardType, data::card::{Card, Suit}, data::poker_hand::PokerHand, tracker::GameContext,
    };

    #[abi(embed_v0)]
    impl RainbowExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            let mut count: u8 = 0;
            let mut count_spades: u8 = 0;
            let mut count_clubs: u8 = 0;
            let mut count_hearts: u8 = 0;
            let mut count_diamonds: u8 = 0;
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
                            } else if *card.suit == Suit::Hearts {
                                count_hearts = count_hearts + 1;
                            } else if *card.suit == Suit::Diamonds {
                                count_diamonds = count_diamonds + 1;
                            }
                            count = count + 1;
                        }
                    },
                    Option::None => { break; },
                }
            };

            if count == count_spades
                + count_clubs
                + count_hearts
                + count_diamonds && count_spades > 0 && count_clubs > 0 && count_hearts > 0 && count_diamonds > 0 {
                (200, 5, 0)
            } else {
                (0, 0, 0)
            }
        }
    }

    #[abi(embed_v0)]
    impl RainbowBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_RAINBOW_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::PokerHand].span()
        }
    }
}
