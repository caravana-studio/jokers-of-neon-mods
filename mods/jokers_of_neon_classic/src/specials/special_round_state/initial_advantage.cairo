#[dojo::contract]
pub mod special_initial_advantage {
    use jokers_of_neon_classic::specials::specials::SPECIAL_INITIAL_ADVANTAGE_ID;
    use jokers_of_neon_lib::interfaces::{base::ICardBase, specials::executable::ISpecialExecutable};
    use jokers_of_neon_lib::models::{card_type::CardType, data::power_up::PowerUp, tracker::GameContext};

    #[abi(embed_v0)]
    impl PowerUpBoosterExecutable of ISpecialExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext) -> (i32, i32, i32) {
            if context.round.remaining_plays.into() == context.game.plays {
                (100, 10, 0)
            } else {
                (0, 0, 0)
            }
        }
    }
}
