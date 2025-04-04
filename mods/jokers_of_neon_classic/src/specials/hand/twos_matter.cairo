#[dojo::contract]
pub mod special_twos_matter {
    use jokers_of_neon_classic::specials::specials::SPECIAL_TWOS_MATTER_ID;
    use jokers_of_neon_lib::interfaces::{
        base::ICardBase, cards::{condition::ICardCondition, executable::ICardExecutable},
    };
    use jokers_of_neon_lib::models::{card_type::CardType, data::card::{Card, Value}, tracker::GameContext};

    #[abi(embed_v0)]
    impl TwosMatterCondition of ICardCondition<ContractState> {
        fn condition(self: @ContractState, context: GameContext, raw_data: felt252) -> bool {
            let card: Card = raw_data.into();
            card.value == Value::Two
        }
    }

    #[abi(embed_v0)]
    impl TwosMatterExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            (30, 0, 0)
        }
    }

    #[abi(embed_v0)]
    impl TwosMatterBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_TWOS_MATTER_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Hand].span()
        }
    }
}
