#[dojo::contract]
pub mod rage_silent_figures {
    use jokers_of_neon_classic::rage::rages_ids::RAGE_CARD_SILENT_FIGURES;
    use jokers_of_neon_lib::interfaces::rage::{base::IRageBase, silence::IRageSilence};
    use jokers_of_neon_lib::models::data::card::{Suit, Value};
    use jokers_of_neon_lib::models::rage_type::RageType;

    #[abi(embed_v0)]
    impl RageSilenceFiguresImpl of IRageSilence<ContractState> {
        fn silenced_suits(self: @ContractState) -> Span<Suit> {
            array![].span()
        }

        fn silenced_values(self: @ContractState) -> Span<Value> {
            array![Value::Jack, Value::Queen, Value::King].span()
        }

        fn silenced_ids(self: @ContractState) -> Span<u32> {
            array![].span()
        }
    }

    #[abi(embed_v0)]
    impl RageSilenceFiguresBase of IRageBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            RAGE_CARD_SILENT_FIGURES
        }

        fn get_type(self: @ContractState) -> RageType {
            RageType::Silence
        }
    }
}
