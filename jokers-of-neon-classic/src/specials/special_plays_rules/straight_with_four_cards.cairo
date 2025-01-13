#[dojo::contract]
pub mod special_straight_with_four_cards {
    use jokers_of_neon_classic::specials::specials::SPECIAL_STRAIGHT_WITH_FOUR_CARDS_ID;
    use jokers_of_neon_lib::interfaces::plays_rules::ISpecialPlaysRulesType;
    use jokers_of_neon_lib::models::poker_hand::PokerHand;
    use jokers_of_neon_lib::models::special_type::SpecialType;

    #[abi(embed_v0)]
    impl SpecialStraightWithFourCardsImpl of ISpecialPlaysRulesType<ContractState> {
        fn apply(ref self: ContractState) -> (PokerHand, u32) {
            (PokerHand::Straight, 4)
        }

        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_STRAIGHT_WITH_FOUR_CARDS_ID
        }

        fn get_type(self: @ContractState) -> SpecialType {
            SpecialType::PlayRules
        }
    }
}
