#[dojo::contract]
pub mod special_parasect {
    use jokers_of_neon_lib::interfaces::poker_hand::ISpecialPokerHand;
    use jokers_of_neon_lib::models::data::poker_hand::PokerHand;
    use jokers_of_neon_lib::models::special_type::SpecialType;
    use jokers_of_neon_lib::models::tracker::GameContext;
    use jokers_of_neon_x_pokermon::specials::specials::SPECIAL_PARASECT_ID;

    #[abi(embed_v0)]
    impl SpecialParasectImpl of ISpecialPokerHand<ContractState> {
        fn execute(
            ref self: ContractState, game_context: GameContext,
        ) -> ((i32, i32, Span<(u32, i32)>), (i32, i32, Span<(u32, i32)>), (i32, i32, Span<(u32, i32)>)) {
            if game_context.hand == PokerHand::TwoPair {
                ((0, 0, array![].span()), (3, 3, array![].span()), (0, 0, array![].span()))
            } else {
                ((0, 0, array![].span()), (-2, -2, array![].span()), (0, 0, array![].span()))
            }
        }

        fn get_id(ref self: ContractState) -> u32 {
            SPECIAL_PARASECT_ID
        }

        fn get_type(ref self: ContractState) -> SpecialType {
            SpecialType::PokerHand
        }
    }
}
