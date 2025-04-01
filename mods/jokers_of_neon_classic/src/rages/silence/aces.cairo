#[dojo::contract]
pub mod rage_silent_aces {
    use jokers_of_neon_classic::rages::rages::RAGE_CARD_SILENT_ACES;
    use jokers_of_neon_lib::{
        interfaces::{base::ICardBase, rages::silence::IRageSilence},
        models::{card_type::CardType, data::card::Value},
    };

    #[abi(embed_v0)]
    impl SilenceAcesImpl of IRageSilence<ContractState> {
        fn silenced_suits(self: @ContractState) -> Span<Suit> {
            array![].span()
        }

        fn silenced_values(self: @ContractState) -> Span<Value> {
            array![Value::Ace].span()
        }

        fn silenced_ids(self: @ContractState) -> Span<u32> {
            array![].span()
        }
    }

    #[abi(embed_v0)]
    impl SilenceAcesBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            RAGE_CARD_SILENT_ACES
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Silence].span()
        }
    }
}
