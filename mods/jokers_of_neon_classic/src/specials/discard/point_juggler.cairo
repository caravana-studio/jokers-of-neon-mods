#[dojo::contract]
pub mod special_point_juggler {
    use jokers_of_neon_classic::specials::specials::SPECIAL_POINT_JUGGLER_ID;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::condition::ICardCondition;
    use jokers_of_neon_lib::interfaces::cards::executable::ICardExecutable;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::data::card::Card;
    use jokers_of_neon_lib::models::tracker::GameContext;

    #[abi(embed_v0)]
    impl PointJugglerCondition of ICardCondition<ContractState> {
        fn condition(self: @ContractState, context: GameContext, raw_data: felt252) -> bool {
            true
        }
    }

    #[abi(embed_v0)]
    impl PointJugglerExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            let card: Card = raw_data.into();
            ((card.points * 10).try_into().unwrap(), 0, 0)
        }
    }

    #[abi(embed_v0)]
    impl PointJugglerBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_POINT_JUGGLER_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Discard].span()
        }
    }
}
