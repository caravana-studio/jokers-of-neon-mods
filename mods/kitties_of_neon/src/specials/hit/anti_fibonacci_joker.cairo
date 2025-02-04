#[dojo::contract]
pub mod special_anti_fibonacci_joker {
    use jokers_of_neon_classic::specials::specials::SPECIAL_ANTI_FIBONACCI_JOKER_ID;
    use jokers_of_neon_lib::interfaces::{
        base::ICardBase, specials::{condition::ISpecialCondition, executable::ISpecialExecutable},
    };
    use jokers_of_neon_lib::models::{card_type::CardType, data::card::{Card, Suit, Value}, tracker::GameContext};

    #[abi(embed_v0)]
    impl AntiFibonacciJokerCondition of ISpecialCondition<ContractState> {
        fn condition(self: @ContractState, raw_data: felt252) -> bool {
            let card: Card = raw_data.into();
            card.value == Value::Four
                || card.value == Value::Six
                || card.value == Value::Seven
                || card.value == Value::Nine
                || card.value == Value::Ten
        }
    }

    #[abi(embed_v0)]
    impl AntiFibonacciJokerExecutable of ISpecialExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            (0, 8, 0)
        }
    }

    #[abi(embed_v0)]
    impl AntiFibonacciJokerBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_ANTI_FIBONACCI_JOKER_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Hit].span()
        }
    }
}
