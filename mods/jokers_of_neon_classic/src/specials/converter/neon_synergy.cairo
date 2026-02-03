#[dojo::contract]
pub mod special_neon_synergy {
    use jokers_of_neon_classic::specials::specials::SPECIAL_NEON_SYNERGY_S2_ID;
    use jokers_of_neon_lib::constants::card::get_card;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::converter::ICardConverter;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::data::card::{Card, CardTrait};
    use jokers_of_neon_lib::models::tracker::GameContext;

    #[abi(embed_v0)]
    impl NeonSynergyConverter of ICardConverter<ContractState> {
        fn apply(ref self: ContractState, context: GameContext, cards: Span<Card>) -> Span<Card> {
            let mut cards = cards;

            // Count neon cards (id >= 200 && id <= 253)
            let mut neon_count: u32 = 0;
            let mut total_count: u32 = 0;
            for card in cards.clone() {
                total_count += 1;
                if *card.id >= 200 && *card.id <= 253 {
                    neon_count += 1;
                }
            }

            // If 50%+ are neon, convert all non-neon to neon
            if total_count > 0 && neon_count * 2 >= total_count {
                let mut result = array![];
                loop {
                    match cards.pop_front() {
                        Option::Some(card) => {
                            let mut new_card = *card;
                            // Convert traditional cards (0-53) to neon
                            if new_card.id >= 0 && new_card.id <= 53 {
                                new_card = get_card(CardTrait::generate_neon_id(new_card.id));
                            }
                            result.append(new_card);
                        },
                        Option::None => { break; },
                    }
                }
                result.span()
            } else {
                cards
            }
        }
    }

    #[abi(embed_v0)]
    impl NeonSynergyBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_NEON_SYNERGY_S2_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::PreCalculateHand].span()
        }
    }
}
