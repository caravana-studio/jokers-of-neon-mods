#[dojo::contract]
pub mod special_joker {
    use jokers_of_neon_classic::specials::specials::SPECIAL_JOKER_ID;
    use jokers_of_neon_lib::interfaces::{base::ICardBase, specials::executable::ISpecialExecutable};
    use jokers_of_neon_lib::models::{card_type::CardType, data::poker_hand::PokerHand, tracker::GameContext};

    #[abi(embed_v0)]
    impl JokerExecutable of ISpecialExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            (0, 4, 0)
        }
    }

    #[abi(embed_v0)]
    impl JokerBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_JOKER_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::PokerHand].span()
        }
    }
}
