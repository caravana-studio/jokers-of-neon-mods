#[dojo::contract]
pub mod special_psyduck {
    use jokers_of_neon_lib::interfaces::poker_hand::ISpecialPokerHand;
    use jokers_of_neon_lib::models::data::card::{Card, Value};
    use jokers_of_neon_lib::models::data::poker_hand::PokerHand;
    use jokers_of_neon_lib::models::special_type::SpecialType;
    use jokers_of_neon_lib::models::tracker::GameContext;
    use jokers_of_neon_x_pokermon::specials::specials::SPECIAL_PSYDUCK_ID;

    #[abi(embed_v0)]
    impl SpecialPsyduckImpl of ISpecialPokerHand<ContractState> {
        fn execute(
            ref self: ContractState, game_context: GameContext,
        ) -> ((i32, i32, Span<(u32, i32)>), (i32, i32, Span<(u32, i32)>), (i32, i32, Span<(u32, i32)>)) {
            if game_context.hand == PokerHand::HighCard {
                let (_, _, card) = *game_context.cards_played.at(0);
                if card.value == Value::Jack || card.value == Value::Queen || card.value == Value::King {
                    ((0, 0, array![].span()), (0, 0, array![].span()), (500, 500, array![].span()))
                } else {
                    ((0, 0, array![].span()), (0, 0, array![].span()), (0, 0, array![].span()))
                }
            } else {
                ((0, 0, array![].span()), (0, 0, array![].span()), (0, 0, array![].span()))
            }
        }

        fn get_id(ref self: ContractState) -> u32 {
            SPECIAL_PSYDUCK_ID
        }

        fn get_type(ref self: ContractState) -> SpecialType {
            SpecialType::PokerHand
        }
    }
}
