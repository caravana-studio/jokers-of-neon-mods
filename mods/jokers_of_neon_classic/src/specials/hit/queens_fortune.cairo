#[dojo::contract]
pub mod special_queens_fortune {
    use crate::utils::random;
    use jokers_of_neon_classic::{constants::DEFAULT_NS, specials::specials::SPECIAL_QUEENS_FORTUNE_ID};
    use jokers_of_neon_lib::{
        interfaces::{base::ICardBase, cards::{condition::ICardCondition, executable::ICardExecutable}},
        models::{card_type::CardType, data::card::{Card, Value}, tracker::GameContext},
    };

    #[abi(embed_v0)]
    impl QueensFortuneCondition of ICardCondition<ContractState> {
        fn condition(self: @ContractState, context: GameContext, raw_data: felt252) -> bool {
            let card: Card = raw_data.into();
            card.value == Value::Queen
        }
    }

    #[abi(embed_v0)]
    impl QueensFortuneExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            let mut world = self.world(DEFAULT_NS());
            if random::between(ref world, context, (1, 2)) == 1 { // 50% chance
                (0, 0, 150)
            } else {
                (0, 0, 0)
            }
        }
    }

    #[abi(embed_v0)]
    impl QueensFortuneBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_QUEENS_FORTUNE_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Hit].span()
        }
    }
}
