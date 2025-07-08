#[dojo::contract]
pub mod rage_strategic_quarted {
    use jokers_of_neon_classic::rages::rages::RAGE_CARD_STRATEGIC_QUARTED;
    use jokers_of_neon_lib::interfaces::{
        base::ICardBase, cards::condition::ICardCondition,
    };
    use jokers_of_neon_lib::models::{card_type::CardType, data::card::{Card, Suit}, data::poker_hand::PokerHand, tracker::GameContext};


    #[abi(embed_v0)]
    impl StrategicQuartedCondition of ICardCondition<ContractState> {
        fn condition(self: @ContractState, context: GameContext, raw_data: felt252) -> bool {
            context.cards_played.len() == 5
        }
    }

    #[abi(embed_v0)]
    impl StrategicQuartedBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            RAGE_CARD_STRATEGIC_QUARTED
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Debuff].span()
        }
    }
}
