#[dojo::contract]
pub mod special_double_down {
    use jokers_of_neon_classic::poker_hand::get_poker_hand_data;
    use jokers_of_neon_classic::specials::specials::SPECIAL_DOUBLE_DOWN_ID;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::executable::ICardExecutable;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::tracker::GameContext;

    #[abi(embed_v0)]
    impl DoubleDownExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            // Doubles the base points of the played hand
            let (poker_hand, level) = context.hand;
            let (base_points, _) = get_poker_hand_data(poker_hand, level);
            let bonus: i32 = (base_points).try_into().unwrap();
            (bonus, 0, 0)
        }
    }

    #[abi(embed_v0)]
    impl DoubleDownBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_DOUBLE_DOWN_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Play].span()
        }
    }
}
