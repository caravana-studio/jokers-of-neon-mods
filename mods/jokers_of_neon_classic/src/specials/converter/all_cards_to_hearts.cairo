#[dojo::contract]
pub mod special_all_cards_to_hearts {
    use jokers_of_neon_classic::specials::specials::SPECIAL_ALL_CARDS_TO_HEARTS_ID;
    use jokers_of_neon_lib::interfaces::{
        base::ICardBase, cards::{condition::ICardCondition, converter::ICardConverter},
    };
    use jokers_of_neon_lib::models::{card_type::CardType, data::card::{Card, Suit}, tracker::GameContext};

    #[abi(embed_v0)]
    impl AllCardsToHeartsCondition of ICardCondition<ContractState> {
        fn condition(self: @ContractState, context: GameContext, raw_data: felt252) -> bool {
            let card: Card = raw_data.into();
            card.suit == Suit::Hearts
        }
    }

    #[abi(embed_v0)]
    impl AllCardsToHeartsConverter of ICardConverter<ContractState> {
        fn apply(ref self: ContractState, context: GameContext, card: Card) -> Card {
            let mut card = card;
            card.suit = Suit::Hearts;
            card
        }
    }

    #[abi(embed_v0)]
    impl AllCardsToHeartsBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_ALL_CARDS_TO_HEARTS_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::PreCalculateHand].span()
        }
    }
}
