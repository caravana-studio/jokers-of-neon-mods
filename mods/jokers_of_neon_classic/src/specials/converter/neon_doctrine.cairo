#[dojo::contract]
pub mod special_neon_doctrine {
    use jokers_of_neon_classic::specials::specials::SPECIAL_NEON_DOCTRINE_ID;
    use jokers_of_neon_lib::constants::card::{JOKER_CARD_ID, NEON_JOKER_CARD};
    use jokers_of_neon_lib::interfaces::{
        base::ICardBase, cards::{condition::ICardCondition, converter::ICardConverter},
    };
    use jokers_of_neon_lib::models::{card_type::CardType, data::card::{Card, Suit, Value}, tracker::GameContext};

    #[abi(embed_v0)]
    impl NeonDoctrineCondition of ICardCondition<ContractState> {
        fn condition(self: @ContractState, context: GameContext, raw_data: felt252) -> bool {
            let card: Card = raw_data.into();
            (card.id >= 0 && card.id <= 53) || card.id == JOKER_CARD_ID
        }
    }

    #[abi(embed_v0)]
    impl NeonDoctrineConverter of ICardConverter<ContractState> {
        fn apply(ref self: ContractState, context: GameContext, card: Card) -> Card {
            let mut card = card;
            let converter = true;

            if converter {
                if card.id == JOKER_CARD_ID {
                    card = NEON_JOKER_CARD();
                } else {
                    card = store.get_card(CardTrait::generate_neon_id(card.id));
                }
            }
            card
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
