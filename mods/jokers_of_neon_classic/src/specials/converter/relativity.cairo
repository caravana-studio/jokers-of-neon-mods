#[dojo::contract]
pub mod special_relativity {
    use jokers_of_neon_classic::specials::specials::SPECIAL_RELATIVITY_ID;
    use jokers_of_neon_lib::constants::card::get_card;
    use jokers_of_neon_lib::interfaces::{base::ICardBase, cards::converter::ICardConverter};
    use jokers_of_neon_lib::models::{
        card_type::CardType, data::card::{Card, CardTrait, Suit, Value}, data::poker_hand::PokerHand,
        tracker::GameContext,
    };

    #[abi(embed_v0)]
    impl RelativityConverter of ICardConverter<ContractState> {
        fn apply(ref self: ContractState, context: GameContext, cards: Span<Card>) -> Span<Card> {
            let (poker_hand, _) = context.hand;
            if poker_hand == PokerHand::Straight || poker_hand == PokerHand::StraightFlush {
                let mut cards = cards;
                let mut result = array![];
                let mut count = 0;
                loop {
                    match cards.pop_front() {
                        Option::Some(card) => {
                            let mut new_card = *card;
                            if new_card.suit != Suit::Joker && new_card.suit != Suit::Wild {
                                if count == 0 {
                                    new_card = get_card(CardTrait::generate_id(Value::Ten, new_card.suit));
                                } else if count == 1 {
                                    new_card = get_card(CardTrait::generate_id(Value::Jack, new_card.suit));
                                } else if count == 2 {
                                    new_card = get_card(CardTrait::generate_id(Value::Queen, new_card.suit));
                                } else if count == 3 {
                                    new_card = get_card(CardTrait::generate_id(Value::King, new_card.suit));
                                } else {
                                    new_card = get_card(CardTrait::generate_id(Value::Ace, new_card.suit));
                                }
                            }
                            count = count + 1;
                            result.append(new_card);
                        },
                        Option::None => { break; },
                    }
                };
                result.span()
            } else {
                cards
            }
        }
    }

    #[abi(embed_v0)]
    impl RelativityBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_RELATIVITY_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::PreCalculateHand].span()
        }
    }
}
