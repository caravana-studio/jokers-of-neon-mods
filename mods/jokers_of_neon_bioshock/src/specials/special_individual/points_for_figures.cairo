#[dojo::contract]
pub mod special_points_for_figures {
    use jokers_of_neon_classic::specials::specials::SPECIAL_POINTS_FOR_FIGURES_ID;
    use jokers_of_neon_lib::interfaces::individual::ISpecialIndividual;
    use jokers_of_neon_lib::models::data::card::{Card, Value};
    use jokers_of_neon_lib::models::special_type::SpecialType;

    #[abi(embed_v0)]
    impl SpecialPointsForFiguresImpl of ISpecialIndividual<ContractState> {
        fn condition(ref self: ContractState, card: Card) -> bool {
            card.value == Value::Jack || card.value == Value::Queen || card.value == Value::King
        }

        fn execute(ref self: ContractState) -> (i32, i32, i32) {
            (50, 0, 0)
        }

        fn get_id(ref self: ContractState) -> u32 {
            SPECIAL_POINTS_FOR_FIGURES_ID
        }

        fn get_types(ref self: ContractState) -> SpecialType {
            SpecialType::Individual
        }
    }
}
