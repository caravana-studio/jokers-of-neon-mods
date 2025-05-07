#[dojo::contract]
pub mod special_queens_fortune {
    use dojo::{model::ModelStorage, world::WorldStorage};
    use jokers_of_neon_classic::specials::specials::SPECIAL_QUEENS_FORTUNE_ID;
    use jokers_of_neon_lib::random::{Nonce, RandomImpl};
    use jokers_of_neon_lib::{
        interfaces::{base::ICardBase, cards::{condition::ICardCondition, executable::ICardExecutable}},
        models::{
            data::card::{Card, Suit, Value}, data::poker_hand::{PokerHand}, {card_type::CardType, tracker::GameContext},
        },
    };

    const NONCE_KEY: felt252 = 'NONCE_KEY';

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
            let mut world = self.world(@"jokers_of_neon_classic");
            let mut nonce: Nonce = world.read_model(NONCE_KEY);
            let mut random = RandomImpl::new_salt(nonce.value);
            nonce.value += 1;
            world.write_model(@nonce);

            if random.between(1, 2) == 1 { // 50% chance
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
