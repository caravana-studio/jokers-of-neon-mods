#[dojo::contract]
pub mod special_blackjack {
    use jokers_of_neon_classic::specials::specials::SPECIAL_BLACKJACK_ID;
    use jokers_of_neon_lib::interfaces::{base::ICardBase, cards::executable::ICardExecutable};
    use jokers_of_neon_lib::models::{card_type::CardType, data::poker_hand::PokerHand, tracker::GameContext};

    #[abi(embed_v0)]
    impl BlackjackExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            let mut acum = 0;
            let mut cards = context.cards_played;
            loop {
                match cards.pop_front() {
                    Option::Some((hit, _, card)) => { if *hit {
                        acum = acum + *card.points;
                    } },
                    Option::None => { break; },
                }
            };

            if acum == 21 {
                (0, 21, 0)
            } else {
                (0, 0, 0)
            }
        }
    }

    #[abi(embed_v0)]
    impl BlackjackBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_BLACKJACK_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::PokerHand].span()
        }
    }
}
