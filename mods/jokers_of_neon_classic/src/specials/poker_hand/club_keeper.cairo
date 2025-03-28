#[dojo::contract]
pub mod special_club_keeper {
    use jokers_of_neon_classic::specials::specials::SPECIAL_CLUB_KEEPER_ID;
    use jokers_of_neon_lib::interfaces::{base::ICardBase, cards::executable::ICardExecutable};
    use jokers_of_neon_lib::models::{
        card_type::CardType, data::card::{Card, Suit}, data::poker_hand::PokerHand, tracker::GameContext,
    };

    #[abi(embed_v0)]
    impl ClubKeeperExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            let mut points = 0;
            let mut cards_in_deck = context.cards_in_deck;
            loop {
                match cards_in_deck.pop_front() {
                    Option::Some(card_id) => {
                        println!("card_id: {}", card_id);
                        let card_id: felt252 = (*card_id).into();
                        let card: Card = card_id.into(); // TODO: Check if this is correct
                        if card.suit == Suit::Clubs {
                            points += 10;
                        }
                    },
                    Option::None => { break; },
                }
            };
            (points, 0, 0)
        }
    }

    #[abi(embed_v0)]
    impl ClubKeeperBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_CLUB_KEEPER_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::PokerHand].span()
        }
    }
}
