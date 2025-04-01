#[dojo::contract]
mod special_initial_advantage {
    use jokers_of_neon_classic::poker_hand::get_poker_hand_data;
    use jokers_of_neon_classic::specials::specials::SPECIAL_DEADLINE_ID;
    use jokers_of_neon_lib::interfaces::{base::ICardBase, cards::executable::ICardExecutable};
    use jokers_of_neon_lib::models::{card_type::CardType, tracker::GameContext};

    #[abi(embed_v0)]
    impl DeadlineExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            if context.round.remaining_plays == 1 {
                let (poker_hand, level) = context.hand;
                let (leveled_points, leveled_multi) = get_poker_hand_data(poker_hand, level + 10);
                let (current_points, current_multi) = get_poker_hand_data(poker_hand, level);
                (
                    (leveled_points - current_points).try_into().unwrap(),
                    (leveled_multi - current_multi).try_into().unwrap(),
                    0,
                )
            } else {
                (0, 0, 0)
            }
        }
    }

    #[abi(embed_v0)]
    impl DeadlineBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_DEADLINE_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::RoundState].span()
        }
    }
}
