#[dojo::contract]
pub mod special_reroll_reactor {
    use jokers_of_neon_classic::specials::specials::SPECIAL_REROLL_REACTOR_ID;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::executable::ICardExecutable;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::tracker::GameContext;

    #[abi(embed_v0)]
    impl RerollReactorExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            (0, (context.game.available_rerolls * 2).try_into().unwrap(), 0)
        }
    }

    #[abi(embed_v0)]
    impl RerollReactorBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_REROLL_REACTOR_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Play].span()
        }
    }
}
