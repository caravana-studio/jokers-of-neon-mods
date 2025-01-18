#[dojo::contract]
pub mod special_life_saver {
    use jokers_of_neon_classic::specials::specials::SPECIAL_LIFE_SAVER_ID;
    use jokers_of_neon_lib::interfaces::round::ISpecialRoundType;
    use jokers_of_neon_lib::models::special_type::SpecialType;
    use jokers_of_neon_lib::models::status::round::round::Round;

    #[abi(embed_v0)]
    impl SpecialShortcutImpl of ISpecialRoundType<ContractState> {
        fn apply(ref self: ContractState, round: Round) -> Round {
            let mut new_round = round;
            // 25% less level score
            new_round.level_score = (new_round.level_score * 75) / 100;
            new_round
        }

        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_LIFE_SAVER_ID
        }

        fn get_type(self: @ContractState) -> SpecialType {
            SpecialType::Round
        }
    }
}
