#[dojo::contract]
pub mod special_discard_mastery {
    use jokers_of_neon_classic::specials::specials::SPECIAL_DISCARD_MASTERY_ID;
    use jokers_of_neon_lib::interfaces::round_state::ISpecialRoundState;
    use jokers_of_neon_lib::models::game::Game;
    use jokers_of_neon_lib::models::round::Round;
    use jokers_of_neon_lib::models::special_type::SpecialType;

    #[abi(embed_v0)]
    impl SpecialDiscardMasteryImpl of ISpecialRoundState<ContractState> {
        fn execute(ref self: ContractState, game: Game, round: Round) -> (u32, u32, u32) {
            if round.discard.is_zero() {
                return (0, 10, 0);
                // world
            //     .emit_event(
            //         @SpecialGlobalEvent {
            //             player: get_caller_address(),
            //             game_id: *game.id,
            //             current_special_card_idx: current_special_cards_index
            //                 .get(SPECIAL_DISCARD_MASTERY_ID.into())
            //                 .deref(),
            //             multi: effect.multi_add,
            //             points: Zeroable::zero()
            //         }
            //     );
            }
            (0, 0, 0)
        }

        fn get_id(ref self: ContractState) -> u32 {
            SPECIAL_DISCARD_MASTERY_ID
        }

        fn get_type(ref self: ContractState) -> SpecialType {
            SpecialType::Individual
        }
    }
}
