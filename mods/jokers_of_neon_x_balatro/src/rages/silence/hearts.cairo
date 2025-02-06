#[dojo::contract]
pub mod rage_silent_hearts {
    use jokers_of_neon_classic::rages::rages::RAGE_CARD_SILENT_HEARTS;
    use jokers_of_neon_lib::{
        interfaces::{base::ICardBase, rages::silence::IRageSilence},
        models::{card_type::CardType, data::card::{Suit, Value}, tracker::GameContext},
    };

    #[abi(embed_v0)]
    impl SilenceHeartsImpl of IRageSilence<ContractState> {
        fn silenced_suits(self: @ContractState) -> Span<Suit> {
            array![Suit::Hearts].span()
        }

        fn silenced_values(self: @ContractState) -> Span<Value> {
            array![].span()
        }

        fn silenced_ids(self: @ContractState) -> Span<u32> {
            array![].span()
        }
    }

    #[abi(embed_v0)]
    impl SilenceHeartsBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            RAGE_CARD_SILENT_HEARTS
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Silence].span()
        }
    }
}
