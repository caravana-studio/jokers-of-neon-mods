#[dojo::contract]
mod special_initial_advantage {
    use jokers_of_neon_classic::specials::specials::SPECIAL_INITIAL_ADVANTAGE_ID;
    use jokers_of_neon_lib::interfaces::{base::ICardBase, specials::executable::ISpecialExecutable};
    use jokers_of_neon_lib::models::{card_type::CardType, tracker::GameContext};

    #[abi(embed_v0)]
    impl InitialAdvantageExecutable of ISpecialExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            if context.round.remaining_plays.into() == context.game.plays {
                (100, 10, 0)
            } else {
                (0, 0, 0)
            }
        }
    }

    #[abi(embed_v0)]
    impl InitialAdvantageBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_INITIAL_ADVANTAGE_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::RoundState].span()
        }
    }
}
