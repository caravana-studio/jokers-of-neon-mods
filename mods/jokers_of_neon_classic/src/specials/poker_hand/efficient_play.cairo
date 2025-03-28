#[dojo::contract]
pub mod special_efficient_play {
    use jokers_of_neon_classic::specials::specials::SPECIAL_EFFICIENT_PLAY_ID;
    use jokers_of_neon_lib::interfaces::{base::ICardBase, cards::executable::ICardExecutable};
    use jokers_of_neon_lib::models::{card_type::CardType, data::poker_hand::PokerHand, tracker::GameContext};

    #[abi(embed_v0)]
    impl EfficientPlayExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            if context.hand == PokerHand::HighCard
                || context.hand == PokerHand::OnePair
                || context.hand == PokerHand::ThreeOfAKind {
                (50, 15, 0)
            } else {
                (0, 0, 0)
            }
        }
    }

    #[abi(embed_v0)]
    impl EfficientPlayBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_EFFICIENT_PLAY_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::PokerHand].span()
        }
    }
}
