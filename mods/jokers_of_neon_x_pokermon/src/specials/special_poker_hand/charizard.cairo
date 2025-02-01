#[dojo::contract]
pub mod special_charizard {
    use jokers_of_neon_lib::interfaces::poker_hand::ISpecialPokerHand;
    use jokers_of_neon_lib::models::data::poker_hand::PokerHand;
    use jokers_of_neon_lib::models::special_type::SpecialType;
    use jokers_of_neon_lib::models::tracker::GameContext;
    use jokers_of_neon_x_pokermon::specials::specials::SPECIAL_CHARIZARD_ID;

    #[abi(embed_v0)]
    impl SpecialCharizardImpl of ISpecialPokerHand<ContractState> {
        fn execute(
            ref self: ContractState, game_context: GameContext,
        ) -> ((i32, i32, Span<(u32, i32)>), (i32, i32, Span<(u32, i32)>), (i32, i32, Span<(u32, i32)>)) {
            ((0, 0, array![].span()), (20, 20, array![].span()), (0, 0, array![].span()))
        }

        fn get_id(ref self: ContractState) -> u32 {
            SPECIAL_CHARIZARD_ID
        }

        fn get_type(ref self: ContractState) -> SpecialType {
            SpecialType::PokerHand
        }
    }
}
