#[dojo::contract]
pub mod special_increase_level_five_of_a_kind {
    use jokers_of_neon_classic::specials::specials::SPECIAL_INCREASE_LEVEL_FIVE_OF_A_KIND_ID;
    use jokers_of_neon_lib::interfaces::{base::ICardBase, specials::executable::ISpecialExecutable};
    use jokers_of_neon_lib::models::{card_type::CardType, data::poker_hand::PokerHand, tracker::GameContext};

    #[abi(embed_v0)]
    impl FiveOfAKindBoostExecutable of ISpecialExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext) -> (i32, i32, i32) {
            if context.hand == PokerHand::FiveOfAKind {
                (20, 4, 0)
            } else {
                (0, 0, 0)
            }
        }
    }

    #[abi(embed_v0)]
    impl FiveOfAKindBoostBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_INCREASE_LEVEL_FIVE_OF_A_KIND_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::PokerHand].span()
        }
    }
}
