#[dojo::contract]
pub mod special_kings_faith {
    use dojo::{model::ModelStorage, world::WorldStorage};
    use jokers_of_neon_classic::specials::specials::SPECIAL_KINGS_FAITH_ID;
    use jokers_of_neon_lib::random::{Nonce, RandomImpl};
    use jokers_of_neon_lib::{
        interfaces::{base::ICardBase, cards::{condition::ICardCondition, executable::ICardExecutable}},
        models::{
            data::card::{Card, Suit, Value}, data::poker_hand::{PokerHand}, {card_type::CardType, tracker::GameContext},
        },
    };

    const NONCE_KEY: felt252 = 'NONCE_KEY';


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
            let mut world = self.world(@"jokers_of_neon_classic");
            if context.card_type == CardType::Hand {
                let mut nonce: Nonce = world.read_model(NONCE_KEY);
                let mut random = RandomImpl::new_salt(nonce.value);
                nonce.value += 1;
                world.write_model(@nonce);

                let points = if random.between(1, 4) == 1 { // 25% chance
                    100
                } else {
                    0
                };
                (points, 0, 0)
            } else if context.card_type == CardType::Hit {
                let mut nonce: Nonce = world.read_model(NONCE_KEY);
                let mut random = RandomImpl::new_salt(nonce.value);
                nonce.value += 1;
                world.write_model(@nonce);

                let cash = if random.between(1, 2) == 1 { // 50% chance
                    100
                } else {
                    0
                };
                (0, 0, cash)
            } else {
                (0, 0, 0)
            }
        }
    }

    // #[abi(embed_v0)]
    // impl KingsFaithExecutable of ICardExecutable<ContractState> {
    //     fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
    //         let mut world = self.world(@"jokers_of_neon_classic");

    //         let mut nonce: Nonce = world.read_model(NONCE_KEY);
    //         let mut random = RandomImpl::new_salt(nonce.value);
    //         nonce.value += 1;
    //         world.write_model(@nonce);

    //         let mut cumulative: Cumulative = world.read_model((context.game.id, HIGH_ROLLER_KEY));
    //         let value = cumulative.value;
    //         let accumulate = random.between(1, 2) == 1; // 50% chance

    //         if accumulate {
    //             let (poker_hand, _) = context.hand;
    //             match poker_hand {
    //                 PokerHand::HighCard => {
    //                     cumulative.value += 1;
    //                     world.write_model(@cumulative);
    //                 },
    //                 _ => {},
    //             };
    //         }
    //         (0, value, 0)
    //     }
    // }

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
