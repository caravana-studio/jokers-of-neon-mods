#[dojo::contract]
pub mod special_increase_level_double_pair {
    use jokers_of_neon_classic::specials::specials::SPECIAL_INCREASE_LEVEL_DOUBLE_PAIR_ID;
    use jokers_of_neon_lib::interfaces::{base::ICardBase, cards::executable::ICardExecutable};
    use jokers_of_neon_lib::models::{card_type::CardType, data::poker_hand::PokerHand, tracker::GameContext};

    #[abi(embed_v0)]
    impl DoublePairBoostExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            let (poker_hand, _) = context.hand;
            if poker_hand == PokerHand::TwoPair {
                (80, 4, 0)
            } else {
                (0, 0, 0)
            }
        }
    }

    #[abi(embed_v0)]
    impl DoublePairBoostBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_INCREASE_LEVEL_DOUBLE_PAIR_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::PokerHand].span()
        }
    }
}
