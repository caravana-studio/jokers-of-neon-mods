#[dojo::contract]
pub mod special_efficient_play {
    use jokers_of_neon_classic::specials::specials::SPECIAL_EFFICIENT_PLAY_ID;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::executable::ICardExecutable;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::data::poker_hand::PokerHand;
    use jokers_of_neon_lib::models::tracker::GameContext;

    #[abi(embed_v0)]
    impl EfficientPlayExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            let (poker_hand, _) = context.hand;
            if poker_hand == PokerHand::HighCard
                || poker_hand == PokerHand::OnePair
                || poker_hand == PokerHand::ThreeOfAKind {
                (50, 10, 0)
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
            array![CardType::Play].span()
        }
    }
}
