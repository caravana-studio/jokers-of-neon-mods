#[dojo::contract]
mod special_score_even {
    use jokers_of_neon_classic::specials::specials::SPECIAL_SCORE_EVEN_ID;
    use jokers_of_neon_lib::interfaces::{base::ICardBase, specials::executable::ISpecialExecutable};
    use jokers_of_neon_lib::models::{card_type::CardType, data::power_up::PowerUp, tracker::GameContext};

    #[abi(embed_v0)]
    impl ScoreEvenExecutable of ISpecialExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            if context.round.player_score % 2 == 0 {
                (50, 5, 0)
            } else {
                (0, 0, 0)
            }
        }
    }

    #[abi(embed_v0)]
    impl ScoreEvenBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_SCORE_EVEN_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::RoundState].span()
        }
    }
}
