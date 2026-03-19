#[dojo::contract]
pub mod special_all_cards_to_hearts {
    use jokers_of_neon_classic::specials::specials::SPECIAL_ALL_CARDS_TO_HEARTS_ID;
    use jokers_of_neon_lib::constants::card::get_card;
    use jokers_of_neon_lib::constants::utils::is_neon_card;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::converter::ICardConverter;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::data::card::{Card, CardTrait, Suit};
    use jokers_of_neon_lib::models::tracker::GameContext;

    #[abi(embed_v0)]
    impl AllCardsToHeartsConverter of ICardConverter<ContractState> {
        fn apply(ref self: ContractState, context: GameContext, cards: Span<Card>) -> Span<Card> {
            let mut result = array![];
            for card in cards {
                let original_card = *card;
                let new_card = if original_card.suit != Suit::Hearts
                    && original_card.suit != Suit::Joker
                    && original_card.suit != Suit::Wild {
                    let new_id = CardTrait::generate_id(original_card.value, Suit::Hearts);
                    if is_neon_card(original_card.id) {
                        get_card(CardTrait::generate_neon_id(new_id))
                    } else {
                        get_card(new_id)
                    }
                } else {
                    original_card
                };
                result.append(new_card);
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
