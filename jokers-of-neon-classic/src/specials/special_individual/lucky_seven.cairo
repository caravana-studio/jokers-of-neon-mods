#[dojo::contract]
pub mod special_lucky_seven {
    use jokers_of_neon_classic::specials::specials::SPECIAL_LUCKY_SEVEN_ID;
    use jokers_of_neon_lib::interfaces::individual::ISpecialIndividual;
    use jokers_of_neon_lib::models::data::card::{Card, Value};
    use jokers_of_neon_lib::models::special_type::SpecialType;

    #[abi(embed_v0)]
    impl SpecialLuckySevenImpl of ISpecialIndividual<ContractState> {
        fn condition(ref self: ContractState, card: Card) -> bool {
            card.value == Value::Seven
        }

        fn execute(ref self: ContractState) -> (u32, u32, u32) {
            (77, 0, 0)
        }

        fn get_id(ref self: ContractState) -> u32 {
            SPECIAL_LUCKY_SEVEN_ID
        }

        fn get_type(ref self: ContractState) -> SpecialType {
            SpecialType::Individual
        }
    }
}
