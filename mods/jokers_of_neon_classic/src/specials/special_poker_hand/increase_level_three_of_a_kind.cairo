#[dojo::contract]
pub mod special_increase_level_three_of_a_kind {
    use jokers_of_neon_classic::specials::specials::SPECIAL_INCREASE_LEVEL_THREE_OF_A_KIND_ID;
    use jokers_of_neon_lib::interfaces::poker_hand::ISpecialPokerHand;
    use jokers_of_neon_lib::models::data::poker_hand::PokerHand;
    use jokers_of_neon_lib::models::play_info::PlayInfo;
    use jokers_of_neon_lib::models::special_type::SpecialType;

    #[abi(embed_v0)]
    impl SpecialIncreaseLevelThreeOfAKindImpl of ISpecialPokerHand<ContractState> {
        fn execute(
            ref self: ContractState, play_info: PlayInfo
        ) -> ((i32, i32, Span<(u32, i32)>), (i32, i32, Span<(u32, i32)>), (i32, i32, Span<(u32, i32)>)) {
            if play_info.hand == PokerHand::ThreeOfAKind {
                ((20, 20, array![].span()), (4, 4, array![].span()), (0, 0, array![].span()))
            } else {
                ((0, 0, array![].span()), (0, 0, array![].span()), (0, 0, array![].span()))
            }
        }

        fn get_id(ref self: ContractState) -> u32 {
            SPECIAL_INCREASE_LEVEL_THREE_OF_A_KIND_ID
        }

        fn get_type(ref self: ContractState) -> SpecialType {
            SpecialType::PokerHand
        }
    }
}
