#[dojo::contract]
pub mod special_charmander {
    use jokers_of_neon_lib::interfaces::round_state::ISpecialRoundState;
    use jokers_of_neon_lib::models::special_type::SpecialType;
    use jokers_of_neon_lib::models::status::game::game::Game;
    use jokers_of_neon_lib::models::status::round::round::Round;
    use jokers_of_neon_x_pokermon::specials::specials::SPECIAL_CHARMANDER_ID;

    #[abi(embed_v0)]
    impl SpecialCharmanderImpl of ISpecialRoundState<ContractState> {
        fn execute(ref self: ContractState, game: Game, round: Round) -> (i32, i32, i32) {
            if round.remaining_discards.is_zero() {
                return (0, 1, 0);
            }
            (0, 0, 0)
        }

        fn get_id(ref self: ContractState) -> u32 {
            SPECIAL_CHARMANDER_ID
        }

        fn get_type(ref self: ContractState) -> SpecialType {
            SpecialType::RoundState
        }
    }
}
