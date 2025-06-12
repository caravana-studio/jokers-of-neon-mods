#[dojo::contract]
pub mod special_kings_faith {
    use dojo::{model::ModelStorage, world::WorldStorage};
    use jokers_of_neon_classic::specials::specials::SPECIAL_KINGS_FAITH_ID;
    use jokers_of_neon_lib::random::{Nonce, RandomTrait};
    use jokers_of_neon_lib::{
        interfaces::{base::ICardBase, cards::{condition::ICardCondition, executable::ICardExecutable}},
        models::{
            data::card::{Card, Suit, Value}, data::poker_hand::{PokerHand}, {card_type::CardType, tracker::GameContext},
        },
    };

    #[abi(embed_v0)]
    impl KingsFaithCondition of ICardCondition<ContractState> {
        fn condition(self: @ContractState, context: GameContext, raw_data: felt252) -> bool {
            let card: Card = raw_data.into();
            card.value == Value::King
        }
    }

    #[abi(embed_v0)]
    impl KingsFaithExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            let mut random = RandomTrait::initialize_random('jokers_of_neon_classic', context.game.seed);
            match context.card_type {
                CardType::Hand => {
                    let points = if random.get_random_number(4) == 1 { // 25% chance
                        100
                    } else {
                        0
                    };
                    (points, 0, 0)
                },
                CardType::Hit => {
                    let cash = if random.get_random_number(2) == 1 { // 50% chance
                        100
                    } else {
                        0
                    };
                    (0, 0, cash)
                },
                _ => { (0, 0, 0) },
            }
        }
    }

    #[abi(embed_v0)]
    impl KingsFaithBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_KINGS_FAITH_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Hit, CardType::Hand].span()
        }
    }
}
