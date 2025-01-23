#[dojo::contract]
pub mod special_growlithe {
    use jokers_of_neon_lib::interfaces::poker_hand::ISpecialPokerHand;
    use jokers_of_neon_lib::models::data::poker_hand::PokerHand;
    use jokers_of_neon_lib::models::play_info::PlayInfo;
    use jokers_of_neon_lib::models::special_type::SpecialType;
    use jokers_of_neon_x_pokermon::specials::specials::SPECIAL_GROWLITHE_ID;

    #[abi(embed_v0)]
    impl SpecialGrowlitheImpl of ISpecialPokerHand<ContractState> {
        fn execute(
            ref self: ContractState, play_info: PlayInfo
        ) -> ((i32, i32, Span<(u32, i32)>), (i32, i32, Span<(u32, i32)>), (i32, i32, Span<(u32, i32)>)) {
            if play_info.hand == PokerHand::Flush {
                ((0, 0, array![].span()), (8, 8, array![].span()), (0, 0, array![].span()))
            } else {
                ((0, 0, array![].span()), (0, 0, array![].span()), (0, 0, array![].span()))
            }
        }

        fn get_id(ref self: ContractState) -> u32 {
            SPECIAL_GROWLITHE_ID
        }

        fn get_type(ref self: ContractState) -> SpecialType {
            SpecialType::PokerHand
        }
    }
}
