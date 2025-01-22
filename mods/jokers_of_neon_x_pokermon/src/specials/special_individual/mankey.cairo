#[dojo::contract]
pub mod special_mankey {
    use jokers_of_neon_lib::interfaces::individual::ISpecialIndividual;
    use jokers_of_neon_lib::models::data::card::{Card, Value};
    use jokers_of_neon_lib::models::special_type::SpecialType;
    use jokers_of_neon_x_pokermon::specials::specials::SPECIAL_MANKEY_ID;

    #[abi(embed_v0)]
    impl SpecialMankeyImpl of ISpecialIndividual<ContractState> {
        fn condition(ref self: ContractState, card: Card) -> bool {
            card.value == Value::Two || card.value == Value::Three || card.value == Value::Five
        }

        fn execute(ref self: ContractState) -> (i32, i32, i32) {
            (5, 3, 0)
        }

        fn get_id(ref self: ContractState) -> u32 {
            SPECIAL_MANKEY_ID
        }

        fn get_type(ref self: ContractState) -> SpecialType {
            SpecialType::Individual
        }
    }
}
