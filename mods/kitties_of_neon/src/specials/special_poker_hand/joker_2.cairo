#[dojo::contract]
pub mod special_joker_2 {
    use jokers_of_neon_classic::specials::specials::SPECIAL_JOKER_2_ID;
    use jokers_of_neon_lib::interfaces::poker_hand::ISpecialPokerHand;
    use jokers_of_neon_lib::models::data::poker_hand::PokerHand;
    use jokers_of_neon_lib::models::play_info::PlayInfo;
    use jokers_of_neon_lib::models::special_type::SpecialType;

    #[abi(embed_v0)]
    impl SpecialJoker2Impl of ISpecialPokerHand<ContractState> {
        fn execute(
            ref self: ContractState, play_info: PlayInfo
        ) -> ((i32, i32, Span<(u32, i32)>), (i32, i32, Span<(u32, i32)>), (i32, i32, Span<(u32, i32)>)) {
            ((0, 0, array![].span()), (6, 6, array![].span()), (0, 0, array![].span()))
        }

        fn get_id(ref self: ContractState) -> u32 {
            SPECIAL_JOKER_2_ID
        }

        fn get_type(ref self: ContractState) -> SpecialType {
            SpecialType::PokerHand
        }
    }
}
