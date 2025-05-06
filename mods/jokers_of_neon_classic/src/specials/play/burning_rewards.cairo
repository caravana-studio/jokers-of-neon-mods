#[dojo::contract]
pub mod special_burning_rewards {
    use dojo::{model::ModelStorage, world::WorldStorage};
    use jokers_of_neon_classic::specials::specials::SPECIAL_BURNING_REWARDS_ID;
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
    const BURNING_REWARDS_KEY: felt252 = 'BURNING_REWARDS_KEY';

    #[abi(embed_v0)]
    impl BurningRewardsExecutable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            let mut world = self.world(@"jokers_of_neon_classic");

            let mut cumulative: Cumulative = world.read_model((context.game.id, BURNING_REWARDS_KEY));
            cumulative.value = context.purchase_tracker.burn_count.try_into().unwrap() * 25;
            world.write_model(@cumulative);
            (cumulative.value, 0, 0)
        }
    }

    #[abi(embed_v0)]
    impl BurningRewardsBase of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_BURNING_REWARDS_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Play, CardType::Info].span()
        }
    }

    #[abi(embed_v0)]
    impl BurningRewardsInfo of ICardInfo<ContractState> {
        fn values(self: @ContractState, game_id: u32) -> (i32, i32, i32) {
            let mut world = self.world(@"jokers_of_neon_classic");
            let cumulative: Cumulative = world.read_model((game_id, BURNING_REWARDS_KEY));
            (cumulative.value, 0, 0)
        }
    }
}
