#[dojo::contract]
pub mod special_initial_advantage {
    use jokers_of_neon_classic::specials::specials::SPECIAL_INITIAL_ADVANTAGE_ID;
    use jokers_of_neon_lib::interfaces::round_state::ISpecialRoundState;
    use jokers_of_neon_lib::models::special_type::SpecialType;
    use jokers_of_neon_lib::models::status::game::game::Game;
    use jokers_of_neon_lib::models::status::round::round::Round;

    #[abi(embed_v0)]
    impl SpecialInitialAdvantageImpl of ISpecialRoundState<ContractState> {
        fn execute(ref self: ContractState, game: Game, round: Round) -> (u32, u32, u32) {
            // first hand
            if game.max_hands == round.hands {
                return (100, 10, 0);
                // world
            //     .emit_event(
            //         @SpecialGlobalEvent {
            //             player: get_caller_address(),
            //             game_id: *game.id,
            //             current_special_card_idx: current_special_cards_index
            //                 .get(SPECIAL_INITIAL_ADVANTAGE_ID.into())
            //                 .deref(),
            //             multi: effect.multi_add,
            //             points: effect.points
            //         }
            //     );
            }
            (0, 0, 0)
        }

        fn get_id(ref self: ContractState) -> u32 {
            SPECIAL_INITIAL_ADVANTAGE_ID
        }

        fn get_type(ref self: ContractState) -> SpecialType {
            SpecialType::Individual
        }
    }
}
