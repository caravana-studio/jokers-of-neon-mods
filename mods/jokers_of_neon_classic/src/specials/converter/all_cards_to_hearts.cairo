#[dojo::contract]
pub mod special_all_cards_to_hearts {
    use jokers_of_neon_classic::specials::specials::SPECIAL_ALL_CARDS_TO_HEARTS_ID;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::converter::ICardConverter;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::data::card::{Card, Suit};
    use jokers_of_neon_lib::models::tracker::GameContext;

    #[abi(embed_v0)]
    impl AllCardsToHeartsConverter of ICardConverter<ContractState> {
        fn apply(ref self: ContractState, context: GameContext, cards: Span<Card>) -> Span<Card> {
            let mut cards = cards;
            let mut result = array![];
            loop {
                match cards.pop_front() {
                    Option::Some(card) => {
                        let mut new_card = *card;
                        if new_card.suit == Suit::Clubs
                            || new_card.suit == Suit::Spades
                            || new_card.suit == Suit::Diamonds {
                            new_card.suit = Suit::Hearts;
                        }
                        result.append(new_card);
                    },
                    Option::None => { break; },
                }
            }
            result.span()
        }
    }

    #[abi(embed_v0)]
    impl AllCardsToHeartsBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_ALL_CARDS_TO_HEARTS_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::PreCalculateHand].span()
        }
    }
}
