#[dojo::contract]
pub mod special_tentacruel {
    use jokers_of_neon_lib::interfaces::individual::ISpecialIndividual;
    use jokers_of_neon_lib::models::data::card::{Card, Value};
    use jokers_of_neon_lib::models::special_type::SpecialType;
    use jokers_of_neon_x_pokermon::specials::specials::SPECIAL_TENTACRUEL_ID;

    #[abi(embed_v0)]
    impl SpecialTentacruelImpl of ISpecialIndividual<ContractState> {
        fn condition(ref self: ContractState, card: Card) -> bool {
            card.value == Value::Ten
        }

        fn execute(ref self: ContractState) -> (i32, i32, i32) {
            (0, 10, 0)
        }

        fn get_id(ref self: ContractState) -> u32 {
            SPECIAL_TENTACRUEL_ID
        }

        fn get_type(ref self: ContractState) -> SpecialType {
            SpecialType::Individual
        }
    }
}
