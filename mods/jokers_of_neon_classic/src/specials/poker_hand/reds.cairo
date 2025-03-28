#[dojo::contract]
pub mod special_reds {
    use jokers_of_neon_classic::specials::specials::SPECIAL_REDS_ID;
    use jokers_of_neon_lib::interfaces::{base::ICardBase, cards::executable::ICardExecutable};
    use jokers_of_neon_lib::models::{
        card_type::CardType, data::card::{Card, Suit}, data::poker_hand::PokerHand, tracker::GameContext,
    };

    #[abi(embed_v0)]
    impl RedsExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            let mut count = 0;
            let mut count_hearts = 0;
            let mut count_diamonds = 0;
            let mut cards = context.cards_played;
            loop {
                match cards.pop_front() {
                    Option::Some((
                        hit, _, card,
                    )) => {
                        if *hit {
                            if *card.suit == Suit::Hearts {
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

            if count == count_hearts + count_diamonds {
                (0, 10, 0)
            } else {
                (0, 0, 0)
            }
        }
    }

    #[abi(embed_v0)]
    impl RedBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_REDS_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::PokerHand].span()
        }
    }
}
