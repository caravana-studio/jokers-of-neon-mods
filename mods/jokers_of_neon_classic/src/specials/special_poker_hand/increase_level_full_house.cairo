#[dojo::contract]
pub mod special_increase_level_full_house {
    use jokers_of_neon_classic::specials::specials::SPECIAL_INCREASE_LEVEL_FULL_HOUSE_ID;
    use jokers_of_neon_lib::interfaces::{base::ICardBase, specials::executable::ISpecialExecutable};
    use jokers_of_neon_lib::models::{card_type::CardType, data::poker_hand::PokerHand, tracker::GameContext};

    #[abi(embed_v0)]
    impl FullHouseBoostExecutable of ISpecialExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            if context.hand == PokerHand::FullHouse {
                (20, 4, 0)
            } else {
                (0, 0, 0)
            }
        }
    }

    #[abi(embed_v0)]
    impl FullHouseBoostBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_INCREASE_LEVEL_FULL_HOUSE_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::PokerHand].span()
        }
    }
}
