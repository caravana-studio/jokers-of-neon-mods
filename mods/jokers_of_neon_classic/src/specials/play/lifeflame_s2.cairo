#[dojo::contract]
pub mod special_lifeflame_s2 {
    use jokers_of_neon_classic::specials::specials::SPECIAL_LIFEFLAME_S2_ID;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::executable::ICardExecutable;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::tracker::GameContext;

    #[abi(embed_v0)]
    impl LifeflameS2Executable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            // +15 points per remaining play + discard
            let remaining: i32 = context.round.remaining_plays.into() + context.round.remaining_discards.into();
            (15 * remaining, 0, 0)
        }
    }

    #[abi(embed_v0)]
    impl LifeflameS2Base of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_LIFEFLAME_S2_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Play].span()
        }
    }
}
