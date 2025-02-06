#[dojo::contract]
pub mod special_devious_joker {
    use jokers_of_neon_classic::specials::specials::SPECIAL_DEVIOUS_JOKER_ID;
    use jokers_of_neon_lib::interfaces::{base::ICardBase, cards::executable::ICardExecutable};
    use jokers_of_neon_lib::models::{card_type::CardType, data::poker_hand::PokerHand, tracker::GameContext};

    #[abi(embed_v0)]
    impl DeviousJokerExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            if context.hand == PokerHand::Straight {
                (100, 100, 0)
            } else {
                (0, 0, 0)
            }
        }
    }

    #[abi(embed_v0)]
    impl DeviousJokerBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_DEVIOUS_JOKER_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::PokerHand].span()
        }
    }
}

