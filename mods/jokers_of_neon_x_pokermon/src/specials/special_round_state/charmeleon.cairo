#[dojo::contract]
pub mod special_charmeleon {
    use jokers_of_neon_lib::interfaces::round_state::ISpecialRoundState;
    use jokers_of_neon_lib::models::special_type::SpecialType;
    use jokers_of_neon_lib::models::status::game::game::Game;
    use jokers_of_neon_lib::models::status::round::round::Round;
    use jokers_of_neon_x_pokermon::specials::specials::SPECIAL_CHARMELEON_ID;

    #[abi(embed_v0)]
    impl SpecialCharmeleonImpl of ISpecialRoundState<ContractState> {
        fn execute(ref self: ContractState, game: Game, round: Round) -> (i32, i32, i32) {
            if round.remaining_discards.is_zero() {
                return (0, 2, 0);
            }
            (0, 0, 0)
        }

        fn get_id(ref self: ContractState) -> u32 {
            SPECIAL_CHARMELEON_ID
        }

        fn get_type(ref self: ContractState) -> SpecialType {
            SpecialType::RoundState
        }
    }
}
