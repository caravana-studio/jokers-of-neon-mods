#[dojo::contract]
pub mod special_cash_loop {
    use jokers_of_neon_classic::specials::specials::SPECIAL_CASH_LOOP_ID;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::executable::ICardExecutable;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::tracker::GameContext;

    #[abi(embed_v0)]
    impl CashLoopExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            (0, 0, 0)
        }
    }

    #[abi(embed_v0)]
    impl CashLoopBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_CASH_LOOP_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Play].span()
        }
    }
}
