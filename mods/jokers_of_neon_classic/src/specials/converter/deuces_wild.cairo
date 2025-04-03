#[dojo::contract]
pub mod special_deuces_wild {
    use jokers_of_neon_classic::specials::specials::SPECIAL_DEUCES_WILD_ID;
    use jokers_of_neon_lib::constants::card::{NEON_WILD_CARD, WILD_CARD};
    use jokers_of_neon_lib::interfaces::{
        base::ICardBase, cards::{condition::ICardCondition, converter::ICardConverter},
    };
    use jokers_of_neon_lib::models::{card_type::CardType, data::card::{Card, Suit, Value}, tracker::GameContext};

    #[abi(embed_v0)]
    impl DeucesWildCondition of ICardCondition<ContractState> {
        fn condition(self: @ContractState, context: GameContext, raw_data: felt252) -> bool {
            let card: Card = raw_data.into();
            card.value == Value::Two
        }
    }

    #[abi(embed_v0)]
    impl DeucesWildConverter of ICardConverter<ContractState> {
        fn apply(ref self: ContractState, context: GameContext, card: Card) -> Card {
            let mut card = card;
            if card.id >= 0 && card.id <= 53 { // is a common card
                card = WILD_CARD();
            } else {
                card = NEON_WILD_CARD();
            }
            card
        }
    }

    #[abi(embed_v0)]
    impl DeucesWildBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_DEUCES_WILD_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::PreCalculateHand].span()
        }
    }
}
