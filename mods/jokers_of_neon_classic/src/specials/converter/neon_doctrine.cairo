#[dojo::contract]
pub mod special_neon_doctrine {
    use dojo::{model::ModelStorage, world::WorldStorage};
    use jokers_of_neon_classic::specials::specials::SPECIAL_NEON_DOCTRINE_ID;
    use jokers_of_neon_lib::constants::card::{JOKER_CARD_ID, WILD_CARD_ID, get_card};
    use jokers_of_neon_lib::interfaces::{base::ICardBase, cards::converter::ICardConverter};
    use jokers_of_neon_lib::models::{
        card_type::CardType, data::card::{Card, CardTrait, Suit, Value}, tracker::GameContext,
    };
    use jokers_of_neon_lib::random::{Nonce, RandomImpl};

    const NONCE_KEY: felt252 = 'NONCE_KEY';

    #[abi(embed_v0)]
    impl AllCardsToHeartsConverter of ICardConverter<ContractState> {
        fn apply(ref self: ContractState, context: GameContext, cards: Span<Card>) -> Span<Card> {
            let mut world = self.world(@"jokers_of_neon_classic");
            let mut nonce: Nonce = world.read_model(NONCE_KEY);
            let mut cards = cards;
            let mut result = array![];
            loop {
                match cards.pop_front() {
                    Option::Some(card) => {
                        let mut random = RandomImpl::new_salt(nonce.value);
                        nonce.value += 1;
                        let mut new_card = *card;
                        if (new_card.id >= 0 && new_card.id <= 53)
                            || new_card.id == JOKER_CARD_ID
                            || new_card.id == WILD_CARD_ID {
                            let converter = random.between(1, 4) == 1; // 25% chance
                            if converter {
                                new_card = get_card(CardTrait::generate_neon_id(new_card.id));
                            }
                        }
                        result.append(new_card);
                    },
                    Option::None => { break; },
                }
            };
            world.write_model(@nonce);
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
