#[dojo::contract]
pub mod rage_flush {
    use jokers_of_neon_classic::rages::rages::RAGE_CARD_FLUSH;
    use jokers_of_neon_lib::{
        interfaces::{base::ICardBase, rages::silence::IRageSilence},
        models::{card_type::CardType, data::card::{Suit, Value}, data::poker_hand::PokerHand, tracker::GameContext},
    };

    #[abi(embed_v0)]
    impl FlushImpl of IRageSilence<ContractState> {
        fn silenced_suits(self: @ContractState) -> Span<Suit> {
            array![].span()
        }

        fn silenced_values(self: @ContractState) -> Span<Value> {
            array![].span()
        }

        fn silenced_ids(self: @ContractState) -> Span<u32> {
            array![].span()
        }

        fn silenced_hands(self: @ContractState, context: GameContext) -> Span<PokerHand> {
            array![PokerHand::Flush].span()
        }
    }

    #[abi(embed_v0)]
    impl FlushBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            RAGE_CARD_FLUSH
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Silence].span()
        }
    }
}
