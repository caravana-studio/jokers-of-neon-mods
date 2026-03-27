#[dojo::contract]
pub mod special_wild_deuces {
    use jokers_of_neon_classic::specials::specials::SPECIAL_WILD_DEUCES_ID;
    use jokers_of_neon_lib::constants::card::{NEON_WILD_CARD, WILD_CARD};
    use jokers_of_neon_lib::constants::utils::is_common_card;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::converter::ICardConverter;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::data::card::{Card, Value};
    use jokers_of_neon_lib::models::tracker::GameContext;

    #[abi(embed_v0)]
    impl WildDeucesConverter of ICardConverter<ContractState> {
        fn apply(ref self: ContractState, context: GameContext, cards: Span<Card>) -> Span<Card> {
            let mut cards = cards;
            let mut result = array![];
            loop {
                match cards.pop_front() {
                    Option::Some(card) => {
                        let mut new_card = *card;
                        if new_card.value == Value::Two {
                            if is_common_card(new_card.id) {
                                new_card = WILD_CARD();
                            } else {
                                new_card = NEON_WILD_CARD();
                            }
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
    impl WildDeucesBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_WILD_DEUCES_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::PreCalculateHand].span()
        }
    }
}
