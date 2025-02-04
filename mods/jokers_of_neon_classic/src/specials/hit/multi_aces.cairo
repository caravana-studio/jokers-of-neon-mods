#[dojo::contract]
pub mod special_multi_aces {
    use jokers_of_neon_classic::specials::specials::SPECIAL_MULTI_ACES_ID;
    use jokers_of_neon_lib::interfaces::{
        base::ICardBase, specials::{condition::ISpecialCondition, executable::ISpecialExecutable},
    };
    use jokers_of_neon_lib::models::{card_type::CardType, data::card::{Card, Value}, tracker::GameContext};

    #[abi(embed_v0)]
    impl MultiAcesCondition of ISpecialCondition<ContractState> {
        fn condition(self: @ContractState, card: Card) -> bool {
            card.value == Value::Ace
        }
    }

    #[abi(embed_v0)]
    impl MultiAcesExecutable of ISpecialExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            (0, 5, 0)
        }
    }

    #[abi(embed_v0)]
    impl MultiAcesBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_MULTI_ACES_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Hit].span()
        }
    }
}
