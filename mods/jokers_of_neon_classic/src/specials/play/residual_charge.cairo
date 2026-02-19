#[dojo::contract]
pub mod special_residual_charge {
    use dojo::model::ModelStorage;
    use jokers_of_neon_classic::constants::DEFAULT_NS;
    use jokers_of_neon_classic::specials::specials::SPECIAL_RESIDUAL_CHARGE_ID;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::executable::ICardExecutable;
    use jokers_of_neon_lib::interfaces::cards::info::ICardInfo;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::data::power_up::PowerUp;
    use jokers_of_neon_lib::models::tracker::GameContext;

    #[dojo::model]
    #[derive(Copy, Drop, Serde)]
    struct CumulativePoints {
        #[key]
        game_id: u32,
        #[key]
        key: felt252,
        value: i32,
    }

    #[dojo::model]
    #[derive(Copy, Drop, Serde)]
    struct CumulativeMulti {
        #[key]
        game_id: u32,
        #[key]
        key: felt252,
        value: i32,
    }

    const SEASON2_5_PTS_KEY: felt252 = 'SEASON2_5_PTS_KEY';
    const SEASON2_5_MULTI_KEY: felt252 = 'SEASON2_5_MULTI_KEY';

    #[abi(embed_v0)]
    impl Season2_5S2Executable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            let mut world = self.world(DEFAULT_NS());

            // If raw_data is non-zero, it's a PowerUp trigger - accumulate 25% of values
            if raw_data != 0 {
                let power_up: PowerUp = raw_data.into();

                let mut cumulative_pts: CumulativePoints = world.read_model((context.game.id, SEASON2_5_PTS_KEY));
                let mut cumulative_multi: CumulativeMulti = world.read_model((context.game.id, SEASON2_5_MULTI_KEY));

                cumulative_pts.value += (power_up.points * 25 / 100).try_into().unwrap();
                cumulative_multi.value += (power_up.multi * 25 / 100).try_into().unwrap();

                world.write_model(@cumulative_pts);
                world.write_model(@cumulative_multi);

                // PowerUp trigger returns 0, accumulation happens silently
                (0, 0, 0)
            } else {
                // Play trigger - return accumulated values
                let cumulative_pts: CumulativePoints = world.read_model((context.game.id, SEASON2_5_PTS_KEY));
                let cumulative_multi: CumulativeMulti = world.read_model((context.game.id, SEASON2_5_MULTI_KEY));
                (cumulative_pts.value, cumulative_multi.value, 0)
            }
        }
    }

    #[abi(embed_v0)]
    impl Season2_5S2Base of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_RESIDUAL_CHARGE_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::PowerUp, CardType::Play, CardType::Info].span()
        }
    }

    #[abi(embed_v0)]
    impl Season2_5S2Info of ICardInfo<ContractState> {
        fn values(self: @ContractState, game_id: u64) -> (i32, i32, i32) {
            let mut world = self.world(DEFAULT_NS());
            let cumulative_pts: CumulativePoints = world.read_model((game_id, SEASON2_5_PTS_KEY));
            let cumulative_multi: CumulativeMulti = world.read_model((game_id, SEASON2_5_MULTI_KEY));
            (cumulative_pts.value, cumulative_multi.value, 0)
        }
    }
}
