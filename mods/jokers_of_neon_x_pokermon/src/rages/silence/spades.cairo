#[dojo::contract]
pub mod rage_silent_spades {
    use jokers_of_neon_lib::interfaces::rage::{base::IRageBase, silence::IRageSilence};
    use jokers_of_neon_lib::models::data::card::{Suit, Value};
    use jokers_of_neon_lib::models::rage_type::RageType;
    use jokers_of_neon_x_pokermon::rages::rages::RAGE_CARD_SILENT_SPADES;

    #[abi(embed_v0)]
    impl RageSilenceSpadesImpl of IRageSilence<ContractState> {
        fn silenced_suits(self: @ContractState) -> Span<Suit> {
            array![Suit::Spades].span()
        }

        fn silenced_values(self: @ContractState) -> Span<Value> {
            array![].span()
        }

        fn silenced_ids(self: @ContractState) -> Span<u32> {
            array![].span()
        }
    }

    #[abi(embed_v0)]
    impl RageSilenceSpadesBase of IRageBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            RAGE_CARD_SILENT_SPADES
        }

        fn get_type(self: @ContractState) -> RageType {
            RageType::Silence
        }
    }
}
