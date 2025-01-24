#[dojo::contract]
pub mod special_banner_joker {
    use jokers_of_neon_classic::specials::specials::SPECIAL_BANNER_JOKER_ID;
    use jokers_of_neon_lib::interfaces::round_state::ISpecialRoundState;
    use jokers_of_neon_lib::models::special_type::SpecialType;
    use jokers_of_neon_lib::models::status::game::game::Game;
    use jokers_of_neon_lib::models::status::round::round::Round;

    #[abi(embed_v0)]
    impl SpecialBannerJokerImpl of ISpecialRoundState<ContractState> {
        fn execute(ref self: ContractState, game: Game, round: Round) -> (i32, i32, i32) {
            let remaining_discards: i32 = round.remaining_discards.try_into().unwrap();
            (0, 0, remaining_discards * 3)
        }

        fn get_id(ref self: ContractState) -> u32 {
            SPECIAL_BANNER_JOKER_ID
        }

        fn get_type(ref self: ContractState) -> SpecialType {
            SpecialType::RoundState
        }
    }
}
