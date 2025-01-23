#[dojo::contract]
pub mod special_fibonacci_joker {
    use jokers_of_neon_classic::specials::specials::SPECIAL_FIBONACCI_JOKER_ID;
    use jokers_of_neon_lib::interfaces::individual::ISpecialIndividual;
    use jokers_of_neon_lib::models::data::card::{Card, Value};
    use jokers_of_neon_lib::models::special_type::SpecialType;

    #[abi(embed_v0)]
    impl SpecialFibonacciJokerImpl of ISpecialIndividual<ContractState> {
        fn condition(ref self: ContractState, card: Card) -> bool {
            card.value == Value::Ace
                || card.value == Value::Two
                || card.value == Value::Three
                || card.value == Value::Five
                || card.value == Value::Eight
        }

        fn execute(ref self: ContractState) -> (i32, i32, i32) {
            (0, 8, 0)
        }

        fn get_id(ref self: ContractState) -> u32 {
            SPECIAL_FIBONACCI_JOKER_ID
        }

        fn get_type(ref self: ContractState) -> SpecialType {
            SpecialType::Individual
        }
    }
}
