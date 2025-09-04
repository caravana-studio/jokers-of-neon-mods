#[dojo::contract]
pub mod special_resonant_multiplier {
    use jokers_of_neon_classic::specials::specials::SPECIAL_RESONANT_MULTIPLIER_ID;
    use jokers_of_neon_lib::{
        interfaces::{base::ICardBase, cards::{condition::ICardCondition, executable::ICardExecutable}},
        models::{card_type::CardType, data::card::{Card, Value}, tracker::GameContext},
    };

    #[abi(embed_v0)]
    impl ResonantMultiplierCondition of ICardCondition<ContractState> {
        fn condition(self: @ContractState, context: GameContext, raw_data: felt252) -> bool {
            let card: Card = raw_data.into();
            match card.value {
                Value::Ace => true,
                Value::Two => true,
                Value::Three => true,
                Value::Four => true,
                Value::Five => true,
                _ => false,
            }
        }
    }

    #[abi(embed_v0)]
    impl ResonantMultiplierExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            let card: Card = raw_data.into();
            let multiplier_value = match card.value {
                Value::Ace => 1,
                Value::Two => 2,
                Value::Three => 3,
                Value::Four => 4,
                Value::Five => 5,
                _ => 0,
            };
            (0, multiplier_value, 0)
        }
    }

    #[abi(embed_v0)]
    impl ResonantMultiplierBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_RESONANT_MULTIPLIER_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Hit].span()
        }
    }
}
