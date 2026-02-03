#[dojo::contract]
pub mod special_season2_1 {
    use dojo::model::ModelStorage;
    use jokers_of_neon_classic::constants::DEFAULT_NS;
    use jokers_of_neon_classic::specials::specials::SPECIAL_SEASON2_1_ID;
    use jokers_of_neon_lib::interfaces::base::ICardBase;
    use jokers_of_neon_lib::interfaces::cards::executable::ICardExecutable;
    use jokers_of_neon_lib::interfaces::cards::info::ICardInfo;
    use jokers_of_neon_lib::models::card_type::CardType;
    use jokers_of_neon_lib::models::tracker::GameContext;

    #[dojo::model]
    #[derive(Copy, Drop, Serde)]
    struct Cumulative {
        #[key]
        game_id: u32,
        #[key]
        key: felt252,
        value: i32,
    }
    const SEASON2_1_KEY: felt252 = 'SEASON2_1_KEY';

    #[abi(embed_v0)]
    impl Season2_1Executable of ICardExecutable<ContractState> {
        fn execute(ref self: ContractState, context: GameContext, raw_data: felt252) -> (i32, i32, i32) {
            let mut world = self.world(DEFAULT_NS());
            let mut cumulative: Cumulative = world.read_model((context.game.id, SEASON2_1_KEY));

            // If 3 or fewer cards played, add +5 to cumulative
            if context.cards_played.len() <= 3 {
                cumulative.value += 5;
                world.write_model(@cumulative);
            }

            (cumulative.value, 0, 0)
        }
    }

    #[abi(embed_v0)]
    impl Season2_1Base of ICardBase<ContractState> {
        fn get_id(self: @ContractState) -> u32 {
            SPECIAL_SEASON2_1_ID
        }

        fn get_types(self: @ContractState) -> Span<CardType> {
            array![CardType::Play, CardType::Info].span()
        }
    }

    #[abi(embed_v0)]
    impl Season2_1Info of ICardInfo<ContractState> {
        fn values(self: @ContractState, game_id: u64) -> (i32, i32, i32) {
            let mut world = self.world(DEFAULT_NS());
            let cumulative: Cumulative = world.read_model((game_id, SEASON2_1_KEY));
            (cumulative.value, 0, 0)
        }
    }
}
