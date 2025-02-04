#[dojo::contract]
pub mod rage_silent_diamonds {
    use jokers_of_neon_classic::rages::rages::RAGE_CARD_SILENT_DIAMONDS;
    use jokers_of_neon_lib::interfaces::rage::{base::IRageBase, silence::IRageSilence};
    use jokers_of_neon_lib::models::data::card::{Suit, Value};
    use jokers_of_neon_lib::models::rage_type::RageType;

    #[abi(embed_v0)]
    impl RageSilenceDiamondsImpl of IRageSilence<ContractState> {
        fn silenced_suits(self: @ContractState) -> Span<Suit> {
            array![Suit::Diamonds].span()
        }

        fn silenced_values(self: @ContractState) -> Span<Value> {
            array![].span()
        }

        fn silenced_ids(self: @ContractState) -> Span<u32> {
            array![].span()
        }
    }

    #[abi(embed_v0)]
    impl RageSilenceDiamondsBase of IRageBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            RAGE_CARD_SILENT_DIAMONDS
        }

        fn get_types(self: @ContractState) -> RageType {
            RageType::Silence
        }
    }
}
