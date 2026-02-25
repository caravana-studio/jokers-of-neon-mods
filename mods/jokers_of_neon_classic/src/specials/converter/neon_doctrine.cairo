#[dojo::contract]
pub mod special_neon_doctrine {
    use jokers_of_neon_classic::constants::DEFAULT_NS;
    use jokers_of_neon_classic::specials::specials::SPECIAL_NEON_DOCTRINE_ID;
    use jokers_of_neon_lib::constants::card::get_card;
    use jokers_of_neon_lib::constants::utils::is_common_card;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::converter::ICardConverter;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::data::card::{Card, CardTrait};
    use jokers_of_neon_lib::models::tracker::GameContext;
    use crate::utils::random;

    #[abi(embed_v0)]
    impl NeonDoctrineConverter of ICardConverter<ContractState> {
        fn apply(ref self: ContractState, context: GameContext, cards: Span<Card>) -> Span<Card> {
            let mut world = self.world(DEFAULT_NS());
            let mut result = array![];
            println!("[NEON_DOCTRINE] cards_len: {}", cards.len());
            for card in cards {
                let mut new_card = *card;
                let is_common = is_common_card(new_card.id);
                // 30% chance (3 out of 10) for common cards
                if is_common {
                    let roll = random::between(ref world, context, (1, 10));
                    if roll <= 3 {
                        let neon_id = CardTrait::generate_neon_id(new_card.id);
                        println!("[NEON_DOCTRINE] CONVERT id:{} -> neon_id:{} roll:{}", new_card.id, neon_id, roll);
                        new_card = get_card(neon_id);
                    } else {
                        println!("[NEON_DOCTRINE] MISS id:{} roll:{}", new_card.id, roll);
                    }
                } else {
                    println!("[NEON_DOCTRINE] SKIP id:{} (not common)", new_card.id);
                }
                result.append(new_card);
            }
            result.span()
        }
    }

    #[abi(embed_v0)]
    impl NeonDoctrinese of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_NEON_DOCTRINE_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::PreCalculateHand].span()
        }
    }
}
