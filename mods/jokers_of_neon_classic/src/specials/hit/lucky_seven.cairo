#[dojo::contract]
pub mod special_lucky_seven {
    use jokers_of_neon_classic::specials::specials::SPECIAL_LUCKY_SEVEN_ID;
    use jokers_of_neon_lib::interfaces::{
        base::ICardBase, specials::{condition::ISpecialCondition, executable::ISpecialExecutable},
    };
    use jokers_of_neon_lib::models::{card_type::CardType, data::card::{Card, Value}, tracker::GameContext};

    #[abi(embed_v0)]
    impl LuckySevenCondition of ISpecialCondition<ContractState> {
        fn condition(self: @ContractState, card: Card) -> bool {
            card.value == Value::Seven
        }
    }

    #[abi(embed_v0)]
    impl LuckySevenExecutable of ISpecialExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext) -> (i32, i32, i32) {
            (77, 0, 0)
        }
    }

    #[abi(embed_v0)]
    impl LuckySevenBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_LUCKY_SEVEN_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Hit].span()
        }
    }
}
