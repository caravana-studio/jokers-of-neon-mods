#[dojo::contract]
pub mod rage_debuff_flush {
    use jokers_of_neon_classic::rages::rages::RAGE_CARD_DEBUFF_FLUSH;
    use jokers_of_neon_lib::interfaces::{base::ICardBase, cards::condition::ICardCondition};
    use jokers_of_neon_lib::models::{
        card_type::CardType, data::card::{Card, Suit}, data::poker_hand::PokerHand, tracker::GameContext,
    };

    #[abi(embed_v0)]
    impl DebuffFlushCondition of ICardCondition<ContractState> {
        fn condition(self: @ContractState, context: GameContext, raw_data: felt252) -> bool {
            let (poker_hand, _) = context.hand;
            poker_hand == PokerHand::Flush
        }
    }

    #[abi(embed_v0)]
    impl DebuffFlushBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            RAGE_CARD_DEBUFF_FLUSH
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Debuff].span()
        }
    }
}
