#[dojo::contract]
pub mod rage_betraying_the_weak {
    use jokers_of_neon_classic::rages::rages::RAGE_CARD_BETRAYING_THE_WEAK;
    use jokers_of_neon_lib::{
        interfaces::{base::ICardBase, rages::silence::IRageSilence},
        models::{card_type::CardType, data::card::{Suit, Value}},
    };

    #[abi(embed_v0)]
    impl BetrayingTheWeakImpl of IRageSilence<ContractState> {
        fn silenced_suits(self: @ContractState) -> Span<Suit> {
            array![].span()
        }

        fn silenced_values(self: @ContractState) -> Span<Value> {
            array![Value::Ace, Value::Two, Value::Three, Value::Four].span()
        }

        fn silenced_ids(self: @ContractState) -> Span<u32> {
            array![].span()
        }
    }

    #[abi(embed_v0)]
    impl BetrayingTheWeakBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            RAGE_CARD_BETRAYING_THE_WEAK
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Silence].span()
        }
    }
}
