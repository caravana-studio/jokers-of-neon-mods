#[dojo::contract]
pub mod special_increase_level_flush {
    use jokers_of_neon_classic::specials::specials::SPECIAL_INCREASE_LEVEL_FLUSH_ID;
    use jokers_of_neon_lib::{
        interfaces::specials::{IBaseSpecial, ISpecialExecutable},
        models::{poker_hand::PokerHand, special_type::SpecialType, tracker::GameContext},
    };

    #[abi(embed_v0)]
    impl SpecialIncreaseLevelFlushImpl of ISpecialPokerHand<ContractState> {
        fn execute(
            ref self: ContractState, game_context: GameContext,
        ) -> ((i32, i32, Span<(u32, i32)>), (i32, i32, Span<(u32, i32)>), (i32, i32, Span<(u32, i32)>)) {
            if game_context.hand == PokerHand::Flush {
                ((20, 20, array![].span()), (4, 4, array![].span()), (0, 0, array![].span()))
            } else {
                ((0, 0, array![].span()), (0, 0, array![].span()), (0, 0, array![].span()))
            }
        }

        fn get_id(ref self: ContractState) -> u32 {
            SPECIAL_INCREASE_LEVEL_FLUSH_ID
        }

        fn get_type(ref self: ContractState) -> SpecialType {
            SpecialType::PokerHand
        }
    }
}
