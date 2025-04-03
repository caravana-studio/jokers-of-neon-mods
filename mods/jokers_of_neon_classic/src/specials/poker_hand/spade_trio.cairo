#[dojo::contract]
pub mod special_spade_trio {
    use jokers_of_neon_classic::specials::specials::SPECIAL_SPADE_TRIO_ID;
    use jokers_of_neon_lib::interfaces::{base::ICardBase, cards::executable::ICardExecutable};
    use jokers_of_neon_lib::models::{
        card_type::CardType, data::card::{Card, Suit}, data::poker_hand::PokerHand, tracker::GameContext,
    };

    #[abi(embed_v0)]
    impl SpadeTrioExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            let mut count_spades: u32 = 0;
            let mut cards = context.cards_played;
            loop {
                match cards.pop_front() {
                    Option::Some((
                        hit, _, card,
                    )) => {
                        if *hit && *card.suit == Suit::Spades {
                            count_spades += 1;
                        }
                    },
                    Option::None => { break; },
                }
            };

            if count_spades >= 3 {
                return (100, 3, 0);
            } else {
                return (0, 0, 0);
            }
        }
    }

    #[abi(embed_v0)]
    impl SpadeTrioBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_SPADE_TRIO_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::PokerHand].span()
        }
    }
}
