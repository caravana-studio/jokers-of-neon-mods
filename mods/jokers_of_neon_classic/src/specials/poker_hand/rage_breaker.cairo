#[dojo::contract]
pub mod special_rage_breaker {
    use dojo::{model::ModelStorage, world::WorldStorage};
    use jokers_of_neon_classic::specials::specials::SPECIAL_RAGE_BREAKER_ID;
    use jokers_of_neon_lib::{
        interfaces::{base::ICardBase, cards::{executable::ICardExecutable, info::ICardInfo}},
        models::{data::poker_hand::{PokerHand}, {card_type::CardType, tracker::GameContext}},
    };

    #[dojo::model]
    #[derive(Copy, Drop, Serde)]
    struct Cumulative {
        #[key]
        game_id: u32,
        #[key]
        key: felt252,
        value: i32,
    }
    const RAGE_BREAKER_KEY: felt252 = 'RAGE_BREAKER_KEY';

    #[abi(embed_v0)]
    impl RageBreakerExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            let mut world = self.world(@"jokers_of_neon_classic");

            let mut cumulative: Cumulative = world.read_model((context.game.id, RAGE_BREAKER_KEY));
            cumulative.value = context.game_tracker.rage_wins.try_into().unwrap() * 3;
            world.write_model(@cumulative);
            (0, cumulative.value, 0)
        }
    }

    #[abi(embed_v0)]
    impl RageBreakerBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_RAGE_BREAKER_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::PokerHand, CardType::Info].span()
        }
    }

    #[abi(embed_v0)]
    impl RageBreakerInfo of ICardInfo<ContractState> {
        fn values(self: @ContractState, game_id: u32) -> (i32, i32, i32) {
            let mut world = self.world(@"jokers_of_neon_classic");
            let cumulative: Cumulative = world.read_model((game_id, RAGE_BREAKER_KEY));
            (0, cumulative.value, 0)
        }
    }
}
