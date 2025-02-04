#[dojo::contract]
pub mod special_score_odd {
    use jokers_of_neon_classic::specials::specials::SPECIAL_SCORE_ODD_ID;
    use jokers_of_neon_lib::interfaces::round_state::ISpecialRoundState;
    use jokers_of_neon_lib::models::special_type::SpecialType;
    use jokers_of_neon_lib::models::status::game::game::Game;
    use jokers_of_neon_lib::models::status::round::round::Round;

    #[abi(embed_v0)]
    impl SpecialScoreEvenImpl of ISpecialRoundState<ContractState> {
        fn execute(ref self: ContractState, game: Game, round: Round) -> (i32, i32, i32) {
            if round.player_score % 2 != 0 {
                return (50, 5, 0);
            }
            (0, 0, 0)
        }

        fn get_id(ref self: ContractState) -> u32 {
            SPECIAL_SCORE_ODD_ID
        }

        fn get_types(ref self: ContractState) -> SpecialType {
            SpecialType::RoundState
        }
    }
}
