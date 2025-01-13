#[dojo::contract]
pub mod special_all_cards_to_hearts {
    use jokers_of_neon_classic::specials::specials::SPECIAL_ALL_CARDS_TO_HEARTS_ID;
    use jokers_of_neon_lib::interfaces::pre_calculate_hand::ISpecialPreCalculateHand;
    use jokers_of_neon_lib::models::card::{Card, Suit};
    use jokers_of_neon_lib::models::special_type::SpecialType;

    #[abi(embed_v0)]
    impl SpecialAllCardsToHeartsImpl of ISpecialPreCalculateHand<ContractState> {
        fn apply(ref self: ContractState, cards: Array<Card>) -> Array<Card> {
            let mut new_cards = array![];
            let mut idx = 0;
            loop {
                if idx == cards.len() {
                    break;
                }
                let mut card = *cards[idx];
                card.suit = if card.suit != Suit::Joker {
                    Suit::Hearts
                } else {
                    card.suit
                };
                new_cards.append(card);
                idx += 1;
            };
            new_cards
        }

        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_ALL_CARDS_TO_HEARTS_ID
        }

        fn get_type(self: @ContractState) -> SpecialType {
            SpecialType::PreCalculateHand
        }
    }
}
