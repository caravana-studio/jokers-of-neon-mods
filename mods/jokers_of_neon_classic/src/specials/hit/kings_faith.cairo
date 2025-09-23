#[dojo::contract]
pub mod special_kings_faith {
    use jokers_of_neon_classic::constants::DEFAULT_NS;
    use jokers_of_neon_classic::specials::specials::SPECIAL_KINGS_FAITH_ID;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::condition::ICardCondition;
    use jokers_of_neon_lib::interfaces::cards::executable::ICardExecutable;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::data::card::{Card, Value};
    use jokers_of_neon_lib::models::tracker::GameContext;
    use crate::utils::random;

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
            let mut world = self.world(DEFAULT_NS());
            // This card has double effect
            match context.card_type {
                CardType::Hand => {
                    let points = if random::between(ref world, context, (1, 4)) == 1 { // 25% chance
                        100
                    } else {
                        0
                    };
                    (points, 0, 0)
                },
                CardType::Hit => {
                    let cash = if random::between(ref world, context, (1, 2)) == 1 { // 50% chance
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
