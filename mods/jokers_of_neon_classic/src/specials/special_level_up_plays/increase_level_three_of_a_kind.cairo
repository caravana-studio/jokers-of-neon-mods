#[dojo::contract]
pub mod special_increase_level_three_of_a_kind {
    use jokers_of_neon_classic::specials::specials::SPECIAL_INCREASE_LEVEL_THREE_OF_A_KIND_ID;
    use jokers_of_neon_lib::interfaces::play_levels::ISpecialLevelUpPlaysType;
    use jokers_of_neon_lib::models::data::poker_hand::PokerHand;
    use jokers_of_neon_lib::models::special_type::SpecialType;

    #[abi(embed_v0)]
    impl SpecialIncreaseLevelThreeOfAKindImpl of ISpecialLevelUpPlaysType<ContractState> {
        fn equip(ref self: ContractState) -> Array<(PokerHand, u32)> {
            array![(PokerHand::ThreeOfAKind, 4)]
        }

        fn unequip(ref self: ContractState) -> Array<(PokerHand, u32)> {
            array![(PokerHand::ThreeOfAKind, 4)]
        }

        fn get_id(ref self: ContractState) -> u32 {
            SPECIAL_INCREASE_LEVEL_THREE_OF_A_KIND_ID
        }

        fn get_type(ref self: ContractState) -> SpecialType {
            SpecialType::LevelUpPlay
        }
    }
}
