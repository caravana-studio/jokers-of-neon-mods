#[dojo::contract]
pub mod special_weedle {
    use jokers_of_neon_lib::interfaces::individual::ISpecialIndividual;
    use jokers_of_neon_lib::models::data::card::Card;
    use jokers_of_neon_lib::models::special_type::SpecialType;
    use jokers_of_neon_x_pokermon::specials::specials::SPECIAL_WEEDLE_ID;

    #[abi(embed_v0)]
    impl SpecialWeedleImpl of ISpecialIndividual<ContractState> {
        fn condition(ref self: ContractState, card: Card) -> bool {
            true // Siempre activo
        }

        fn execute(ref self: ContractState) -> (i32, i32, i32) {
            (16, 0, 0)
        }

        fn get_id(ref self: ContractState) -> u32 {
            SPECIAL_WEEDLE_ID
        }

        fn get_type(ref self: ContractState) -> SpecialType {
            SpecialType::Individual
        }
    }
}
