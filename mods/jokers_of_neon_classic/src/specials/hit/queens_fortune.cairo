#[dojo::contract]
pub mod special_queens_fortune {
    use dojo::model::ModelStorage;
    use dojo::world::WorldStorage;
    use jokers_of_neon_classic::specials::specials::SPECIAL_QUEENS_FORTUNE_ID;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::condition::ICardCondition;
    use jokers_of_neon_lib::interfaces::cards::executable::ICardExecutable;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::data::card::{Card, Suit, Value};
    use jokers_of_neon_lib::models::data::poker_hand::PokerHand;
    use jokers_of_neon_lib::models::tracker::GameContext;
    use jokers_of_neon_lib::random::{Nonce, RandomTrait};

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
            let mut random = RandomTrait::initialize_random('jokers_of_neon_classic', context.game.seed);
            if random.get_random_number(2) == 1 { // 50% chance
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
