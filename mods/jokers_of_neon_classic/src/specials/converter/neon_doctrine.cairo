#[dojo::contract]
pub mod special_neon_doctrine {
    use crate::utils::random;
    use jokers_of_neon_classic::{constants::DEFAULT_NS, specials::specials::SPECIAL_NEON_DOCTRINE_ID};
    use jokers_of_neon_lib::{
        constants::card::{JOKER_CARD_ID, WILD_CARD_ID, get_card},
        interfaces::{base::ICardBase, cards::converter::ICardConverter},
        models::{card_type::CardType, data::card::{Card, CardTrait, Suit, Value}, tracker::GameContext},
    };

    #[abi(embed_v0)]
    impl NeonDoctrineConverter of ICardConverter<ContractState> {
        fn apply(ref self: ContractState, context: GameContext, cards: Span<Card>) -> Span<Card> {
            let mut world = self.world(DEFAULT_NS());
            let mut cards = cards;
            let mut result = array![];
            loop {
                match cards.pop_front() {
                    Option::Some(card) => {
                        let mut new_card = *card;
                        if (new_card.id >= 0 && new_card.id <= 53)
                            || new_card.id == JOKER_CARD_ID
                            || new_card.id == WILD_CARD_ID {
                            if random::between(ref world, context, (1, 4)) == 1 { // 25% chance
                                new_card = get_card(CardTrait::generate_neon_id(new_card.id));
                            }
                        }
                        result.append(new_card);
                    },
                    Option::None => { break; },
                }
            };
            result.span()
        }
    }

    #[abi(embed_v0)]
    impl NeonDoctrineBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_NEON_DOCTRINE_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::PreCalculateHand].span()
        }
    }
}
