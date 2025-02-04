#[dojo::contract]
pub mod special_initial_advantage {
    use jokers_of_neon_classic::specials::specials::SPECIAL_INITIAL_ADVANTAGE_ID;
    use jokers_of_neon_lib::interfaces::round_state::ISpecialRoundState;
    use jokers_of_neon_lib::models::special_type::SpecialType;
    use jokers_of_neon_lib::models::status::game::game::Game;
    use jokers_of_neon_lib::models::status::round::round::Round;

    #[abi(embed_v0)]
    impl SpecialInitialAdvantageImpl of ISpecialRoundState<ContractState> {
        fn execute(ref self: ContractState, game: Game, round: Round) -> (i32, i32, i32) {
            // first hand
            if round.remaining_plays.into() == game.plays {
                return (200, 5, 0);
            }
            (0, 0, 0)
        }

        fn get_id(ref self: ContractState) -> u32 {
            SPECIAL_INITIAL_ADVANTAGE_ID
        }

        fn get_types(ref self: ContractState) -> SpecialType {
            SpecialType::RoundState
        }
    }
}
