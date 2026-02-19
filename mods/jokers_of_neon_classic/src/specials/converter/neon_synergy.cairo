#[dojo::contract]
pub mod special_neon_synergy {
    use jokers_of_neon_classic::specials::specials::SPECIAL_NEON_SYNERGY_ID;
    use jokers_of_neon_lib::constants::card::get_card;
    use jokers_of_neon_lib::constants::utils::{is_common_card, is_neon_card};
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::converter::ICardConverter;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::data::card::{Card, CardTrait};
    use jokers_of_neon_lib::models::tracker::GameContext;

    #[abi(embed_v0)]
    impl NeonSynergyS2Converter of ICardConverter<ContractState> {
        fn apply(ref self: ContractState, context: GameContext, cards: Span<Card>) -> Span<Card> {
            // Count neon cards
            let mut neon_count: u32 = 0;
            let mut total_count: u32 = 0;
            for card in cards {
                total_count += 1;
                if is_neon_card(*card.id) {
                    neon_count += 1;
                }
            }

            // If 50%+ are neon, convert all non-neon to neon
            if total_count > 0 && neon_count * 2 >= total_count {
                let mut result = array![];
                for card in cards {
                    let mut new_card = *card;
                    // Convert common cards to neon
                    if is_common_card(new_card.id) {
                        new_card = get_card(CardTrait::generate_neon_id(new_card.id));
                    }
                    result.append(new_card);
                }
                result.span()
            } else {
                cards
            }
        }
    }

    #[abi(embed_v0)]
    impl NeonSynergyS2Base of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_NEON_SYNERGY_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::PreCalculateHand].span()
        }
    }
}
