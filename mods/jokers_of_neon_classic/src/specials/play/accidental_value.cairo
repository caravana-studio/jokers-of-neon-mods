#[dojo::contract]
pub mod special_accidental_value {
    use jokers_of_neon_classic::specials::specials::SPECIAL_ACCIDENTAL_VALUE_ID;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::condition::ICardCondition;
    use jokers_of_neon_lib::interfaces::cards::executable::ICardExecutable;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::tracker::GameContext;

    #[abi(embed_v0)]
    impl AccidentalValueCondition of ICardCondition<ContractState> {
        fn condition(self: @ContractState, context: GameContext, raw_data: felt252) -> bool {
            true
        }
    }

    #[abi(embed_v0)]
    impl AccidentalValueExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            (25, 1, 0)
        }
    }

    #[abi(embed_v0)]
    impl AccidentalValueBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_ACCIDENTAL_VALUE_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Miss].span()
        }
    }
}
