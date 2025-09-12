#[dojo::contract]
pub mod special_jackpot {
    use jokers_of_neon_classic::specials::specials::SPECIAL_JACKPOT_ID;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::condition::ICardCondition;
    use jokers_of_neon_lib::interfaces::cards::executable::ICardExecutable;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::data::card::{Card, Value};
    use jokers_of_neon_lib::models::tracker::GameContext;

    #[abi(embed_v0)]
    impl JackpotCondition of ICardCondition<ContractState> {
        fn condition(self: @ContractState, context: GameContext, raw_data: felt252) -> bool {
            let card: Card = raw_data.into();
            card.value == Value::Jack
        }
    }

    #[abi(embed_v0)]
    impl JackpotExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            (30, 0, 0)
        }
    }

    #[abi(embed_v0)]
    impl JackpotBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_JACKPOT_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Hand].span()
        }
    }
}
