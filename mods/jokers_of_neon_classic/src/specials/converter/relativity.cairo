#[dojo::contract]
pub mod special_relativity {
    use jokers_of_neon_classic::specials::specials::SPECIAL_RELATIVITY_ID;
    use jokers_of_neon_lib::constants::card::get_card;
    use jokers_of_neon_lib::constants::utils::is_neon_card;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::converter::ICardConverter;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::data::card::{Card, CardTrait, Suit, Value};
    use jokers_of_neon_lib::models::data::poker_hand::PokerHand;
    use jokers_of_neon_lib::models::tracker::GameContext;

    #[abi(embed_v0)]
    impl RelativityConverter of ICardConverter<ContractState> {
        fn apply(ref self: ContractState, context: GameContext, cards: Span<Card>) -> Span<Card> {
            let (poker_hand, _) = context.hand;
            if poker_hand == PokerHand::Straight || poker_hand == PokerHand::StraightFlush {
                let mut result = array![];
                let mut count = 0;
                for card in cards {
                    let original_card = *card;
                    let mut new_card = original_card;
                    if new_card.suit != Suit::Joker && new_card.suit != Suit::Wild {
                        let new_id = if count == 0 {
                            CardTrait::generate_id(Value::Ten, new_card.suit)
                        } else if count == 1 {
                            CardTrait::generate_id(Value::Jack, new_card.suit)
                        } else if count == 2 {
                            CardTrait::generate_id(Value::Queen, new_card.suit)
                        } else if count == 3 {
                            CardTrait::generate_id(Value::King, new_card.suit)
                        } else {
                            CardTrait::generate_id(Value::Ace, new_card.suit)
                        };
                        // Preserve neon status from previous converters
                        new_card =
                            if is_neon_card(original_card.id) {
                                get_card(CardTrait::generate_neon_id(new_id))
                            } else {
                                get_card(new_id)
                            };
                    }
                    count = count + 1;
                    result.append(new_card);
                }
                result.span()
            } else {
                cards
            }
        }
    }

    #[abi(embed_v0)]
    impl Relativityse of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_RELATIVITY_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::PreCalculateHand].span()
        }
    }
}
