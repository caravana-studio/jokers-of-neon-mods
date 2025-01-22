#[dojo::contract]
pub mod special_half_joker {
    use jokers_of_neon_classic::specials::specials::SPECIAL_HALF_JOKER_ID;
    use jokers_of_neon_lib::interfaces::poker_hand::ISpecialPokerHand;
    use jokers_of_neon_lib::models::data::poker_hand::PokerHand;
    use jokers_of_neon_lib::models::play_info::PlayInfo;
    use jokers_of_neon_lib::models::special_type::SpecialType;

    #[abi(embed_v0)]
    impl SpecialHalfJokerImpl of ISpecialPokerHand<ContractState> {
        fn execute(
            ref self: ContractState, play_info: PlayInfo
        ) -> ((i32, Span<(u32, i32)>), (i32, Span<(u32, i32)>), (i32, Span<(u32, i32)>)) {
            if play_info.hand == PokerHand::HighCard
                || play_info.hand == PokerHand::OnePair
                || play_info.hand == PokerHand::ThreeOfAKind {
                ((0, array![].span()), (20, array![].span()), (0, array![].span()))
            } else {
                ((0, array![].span()), (0, array![].span()), (0, array![].span()))
            }
        }

        fn get_id(ref self: ContractState) -> u32 {
            SPECIAL_HALF_JOKER_ID
        }

        fn get_type(ref self: ContractState) -> SpecialType {
            SpecialType::PokerHand
        }
    }
}
