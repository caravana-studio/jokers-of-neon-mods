#[dojo::contract]
pub mod special_flush_with_four_cards {
    use jokers_of_neon_classic::specials::specials::SPECIAL_FLUSH_WITH_FOUR_CARDS_ID;
    use jokers_of_neon_lib::interfaces::plays_rules::ISpecialPlaysRulesType;
    use jokers_of_neon_lib::models::data::poker_hand::PokerHand;
    use jokers_of_neon_lib::models::special_type::SpecialType;

    #[abi(embed_v0)]
    impl SpecialFlushWithFourCardsImpl of ISpecialPlaysRulesType<ContractState> {
        fn apply(ref self: ContractState) -> (PokerHand, u32) {
            (PokerHand::Flush, 4)
        }

        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_FLUSH_WITH_FOUR_CARDS_ID
        }

        fn get_type(self: @ContractState) -> SpecialType {
            SpecialType::PlayRules
        }
    }
}
