#[dojo::contract]
pub mod special_fibonacci_joker {
    use jokers_of_neon_classic::specials::specials::SPECIAL_FIBONACCI_JOKER_ID;
    use jokers_of_neon_lib::interfaces::{
        base::ICardBase, specials::{condition::ISpecialCondition, executable::ISpecialExecutable},
    };
    use jokers_of_neon_lib::models::{card_type::CardType, data::card::{Card, Suit, Value}, tracker::GameContext};

    #[abi(embed_v0)]
    impl FibonacciJokerCondition of ISpecialCondition<ContractState> {
        fn condition(self: @ContractState, raw_data: felt252) -> bool {
            let card: Card = raw_data.into();
            card.value == Value::Ace
                || card.value == Value::Two
                || card.value == Value::Three
                || card.value == Value::Five
                || card.value == Value::Eight
        }
    }

    #[abi(embed_v0)]
    impl FibonacciJokerExecutable of ISpecialExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            (0, 8, 0)
        }
    }

    #[abi(embed_v0)]
    impl FibonacciJokerBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_FIBONACCI_JOKER_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Hit].span()
        }
    }
}
